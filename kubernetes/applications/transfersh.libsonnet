local defaults = {
  fqdn: 'transfersh.augustfeng.app',
  labels: { 'app.kubernetes.io/name': 'transfersh' },
};

function(params={})
  local config = defaults + params;

  {
    Namespace: {
      transfersh: {
        apiVersion: 'v1',
        kind: 'Namespace',
        metadata: {
          name: 'transfersh',
        },
      },
    },
    StatefulSet: {
      transfersh: {
        apiVersion: 'apps/v1',
        kind: 'StatefulSet',
        metadata: {
          namespace: 'transfersh',
          name: 'transfersh',
        },
        spec: {
          selector: {
            matchLabels: config.labels,
          },
          serviceName: 'transfersh',
          replicas: 1,
          template: {
            metadata: {
              labels: config.labels,
            },
            spec: {
              containers: [
                {
                  name: 'transfersh',
                  image: 'dutchcoders/transfer.sh',
                  args: [
                    '--provider=local',
                    '--basedir=/data/',
                  ],
                  ports: [
                    {
                      containerPort: 8080,
                    },
                  ],
                  volumeMounts: [
                    {
                      name: 'tmp',
                      mountPath: '/tmp',
                    },
                    {
                      name: 'transfersh-data',
                      mountPath: '/data',
                    },
                  ],
                },
              ],
              volumes: [
                {  // https://github.com/dutchcoders/transfer.sh/issues/462
                  name: 'tmp',
                  emptyDir: {},
                },
              ],
            },
          },
          volumeClaimTemplates: [
            {
              metadata: {
                name: 'transfersh-data',
              },
              spec: {
                accessModes: ['ReadWriteOnce'],
                resources: {
                  requests: {
                    storage: '10Gi',
                  },
                },
              },
            },
          ],
        },
      },
    },
    Service: {
      transfersh: {
        apiVersion: 'v1',
        kind: 'Service',
        metadata: {
          namespace: 'transfersh',
          name: 'transfersh',
        },
        spec: {
          ports: [
            {
              port: 8080,
              targetPort: 8080,
            },
          ],
          selector: config.labels,
        },
      },
    },
    Ingress: {
      transfersh: {
        apiVersion: 'networking.k8s.io/v1',
        kind: 'Ingress',
        metadata: {
          annotations: {
            'ingress.kubernetes.io/ssl-redirect': 'false',
          },
          name: 'transfersh',
          namespace: 'transfersh',
        },
        spec: {
          rules: [
            {
              host: config.fqdn,
              http: {
                paths: [
                  {
                    path: '/',
                    pathType: 'Prefix',
                    backend: {
                      service: {
                        name: 'transfersh',
                        port: {
                          number: 8080,
                        },
                      },
                    },
                  },
                ],
              },
            },
          ],
          tls: [
            {
              secretName: '%s-tls' % config.fqdn,
            },
          ],
        },
      },
    },
    Certificate: {
      ['%s' % config.fqdn]: {
        apiVersion: 'cert-manager.io/v1',
        kind: 'Certificate',
        metadata: {
          namespace: 'transfersh',
          name: config.fqdn,
        },
        spec: {
          secretName: '%s-tls' % config.fqdn,
          dnsNames: [
            config.fqdn,
          ],
          issuerRef: {
            name: 'letsencrypt-augustfengd',
            kind: 'ClusterIssuer',
          },
        },
      },
    },
  }
