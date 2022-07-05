local defaults = {
  fqdn: 'huginn.augustfeng.app',
  labels: { 'app.kubernetes.io/name': 'huginn' },
  credentials: {
    admin: {
      username: 'admin',
      password: 'password',
    },
  },
  postgresql: {
    labels: { 'app.kubernetes.io/name': 'postgresql' },
    credentials: {
      admin: {
        user: 'postgres',
        password: 'foobar',
      },
      huginn: {
        user: 'huginn',
        password: 'foobar',
      },
    },
  },
};

function(params={})
  local config = defaults + params;

  {
    Namespace: {
      huginn: {
        apiVersion: 'v1',
        kind: 'Namespace',
        metadata: {
          name: 'huginn',
        },
      },
    },
    Secret: {
      'huginn-credentials': {
        apiVersion: 'v1',
        kind: 'Secret',
        metadata: {
          name: 'huginn-credentials',
          namespace: 'huginn',
          labels: config.labels,
        },
        data: {
          user: std.base64(config.credentials.admin.username),
          password: std.base64(config.credentials.admin.password),
        },
      },
      'postgresql-credentials': {
        apiVersion: 'v1',
        kind: 'Secret',
        metadata: {
          name: 'postgresql-credentials',
          namespace: 'huginn',
          labels: config.postgresql.labels,
        },
        data: {
          user: std.base64(config.postgresql.credentials.admin.user),
          password: std.base64(config.postgresql.credentials.admin.password),
        },
      },
      'postgresql-credentials-huginn': {
        apiVersion: 'v1',
        kind: 'Secret',
        metadata: {
          name: 'postgresql-credentials-huginn',
          namespace: 'huginn',
          labels: config.postgresql.labels,
        },
        data: {
          user: std.base64(config.postgresql.credentials.huginn.user),
          password: std.base64(config.postgresql.credentials.huginn.password),
        },
      },
    },
    ConfigMap: {
      'postgresql-init': {
        apiVersion: 'v1',
        kind: 'ConfigMap',
        metadata: {
          name: 'postgresql-init',
          namespace: 'huginn',
          labels: config.postgresql.labels,
        },
        data: {
          'init-huginn.sql': |||
            CREATE USER %(user)s WITH PASSWORD '%(password)s' CREATEDB;
          ||| % config.postgresql.credentials.huginn,  // TODO: find a way to manage credentials more dynamically.
        },
      },
    },
    Deployment: {
      huginn: {
        apiVersion: 'apps/v1',
        kind: 'Deployment',
        metadata: {
          name: 'huginn',
          namespace: 'huginn',
          labels: config.labels,
        },
        spec: {
          selector: {
            matchLabels: config.labels,
          },
          template: {
            metadata: {
              labels: config.labels,
            },
            spec: {
              containers: [
                {
                  name: 'huginn',
                  image: 'huginn/huginn',
                  ports: [
                    {
                      containerPort: 3000,
                    },
                  ],
                  env: [
                    {
                      name: 'DATABASE_ADAPTER',
                      value: 'postgresql',
                    },
                    {
                      name: 'DATABASE_HOST',
                      value: 'postgresql.huginn.svc.cluster.local',
                    },
                    {
                      name: 'DATABASE_USERNAME',
                      valueFrom: {
                        secretKeyRef:
                          {
                            name: 'postgresql-credentials-huginn',
                            key: 'user',
                          },
                      },
                    },
                    {
                      name: 'DATABASE_PASSWORD',
                      valueFrom: {
                        secretKeyRef:
                          {
                            name: 'postgresql-credentials-huginn',
                            key: 'password',
                          },
                      },
                    },
                  ],
                },
              ],
            },
          },
        },
      },
    },
    StatefulSet: {
      postgresql: {
        apiVersion: 'apps/v1',
        kind: 'StatefulSet',
        metadata: {
          name: 'postgresql',
          namespace: 'huginn',
          labels: config.postgresql.labels,
        },
        spec: {
          replicas: 1,
          serviceName: 'postgresql',
          selector: { matchLabels: config.postgresql.labels },
          template: {
            metadata: {
              labels: config.postgresql.labels,
            },
            spec: {
              containers: [
                {
                  name: 'postgresql',
                  image: 'postgres:latest',
                  env: [
                    {
                      name: 'POSTGRES_USER',
                      valueFrom: {
                        secretKeyRef:
                          {
                            name: 'postgresql-credentials',
                            key: 'user',
                          },
                      },
                    },
                    {
                      name: 'POSTGRES_PASSWORD',
                      valueFrom: {
                        secretKeyRef:
                          {
                            name: 'postgresql-credentials',
                            key: 'password',
                          },
                      },
                    },
                  ],
                  ports: [
                    {
                      containerPort: 5432,
                    },
                  ],
                  volumeMounts: [
                    {
                      name: 'data',
                      mountPath: '/var/lib/postgresql/data',
                    },
                    {
                      name: 'init',
                      mountPath: '/docker-entrypoint-initdb.d/%s' % self.subPath,
                      subPath: 'init-huginn.sql',
                    },
                  ],
                },
              ],
              volumes: [
                {
                  name: 'init',
                  configMap: {
                    name: 'postgresql-init',
                  },
                },
              ],
            },
          },
          volumeClaimTemplates: [
            {
              metadata: {
                name: 'data',
              },
              spec: {
                accessModes: ['ReadWriteOnce'],
                resources: {
                  requests: {
                    storage: '8Gi',
                  },
                },
              },
            },
          ],
        },
      },
    },
    Service: {
      huginn: {
        apiVersion: 'v1',
        kind: 'Service',
        metadata: {
          namespace: 'huginn',
          name: 'huginn',
        },
        spec: {
          ports: [
            {
              port: 3000,
              targetPort: 3000,
            },
          ],
          selector: config.labels,
        },
      },
      postgresql: {
        apiVersion: 'v1',
        kind: 'Service',
        metadata: {
          namespace: 'huginn',
          name: 'postgresql',
        },
        spec: {
          ports: [
            {
              port: 5432,
              targetPort: 5432,
            },
          ],
          selector: config.postgresql.labels,
        },
      },
    },
  }
