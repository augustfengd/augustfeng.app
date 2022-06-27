local defaults = {
  fqdn: 'blog.augustfeng.app',
  labels: { 'app.kubernetes.io/name': 'blog' },
};

function(params={})
  local config = defaults + params;

  {
    Namespace: {
      blog: {
        apiVersion: 'v1',
        kind: 'Namespace',
        metadata: {
          name: 'blog',
        },
      },
    },
    Deployment: {
      blog: {
        apiVersion: 'apps/v1',
        kind: 'Deployment',
        metadata: {
          namespace: 'blog',
          name: 'blog',
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
                  name: 'hugo',
                  image: 'klakegg/hugo',
                  args: [
                    'server',
                    '--baseUrl=%s' % config.fqdn,
                    '--bind=0.0.0.0',
                    '--appendPort=false',
                  ],
                  ports: [
                    {
                      containerPort: 1313,
                    },
                  ],
                  volumeMounts: [
                    {
                      name: 'src',
                      mountPath: '/src',
                      subPath: 'web/blog',
                    },
                  ],
                },
              ],
              initContainers: [
                {
                  name: 'git-clone',
                  image: 'alpine/git',
                  command: [
                    'git',
                    'clone',
                    'https://github.com/augustfengd/augustfeng.app.git',
                    '/src',
                  ],
                  volumeMounts: [
                    {
                      name: 'src',
                      mountPath: '/src',
                    },
                  ],
                },
                {
                  name: 'git-switch',
                  image: 'alpine/git',
                  command: [
                    'git',
                    '-C',
                    '/src',
                    'switch',
                    'main',
                  ],
                  volumeMounts: [
                    {
                      name: 'src',
                      mountPath: '/src',
                    },
                  ],
                },
                {
                  name: 'gcc',
                  image: 'gcc',
                  args: [
                    'make',
                    '-C',
                    '/blog',
                  ],
                  volumeMounts: [
                    {
                      name: 'src',
                      mountPath: '/blog',
                      subPath: 'web/blog',
                    },
                  ],
                },
              ],
              volumes: [
                {
                  name: 'src',
                  emptyDir: {},
                },
              ],
            },
          },
        },
      },
    },
    Service: {
      blog: {
        apiVersion: 'v1',
        kind: 'Service',
        metadata: {
          namespace: 'blog',
          name: 'blog',
        },
        spec: {
          ports: [
            {
              port: 1313,
              targetPort: 1313,
            },
          ],
          selector: config.labels,
        },
      },
    },
    Ingress: {
      blog: {
        apiVersion: 'networking.k8s.io/v1',
        kind: 'Ingress',
        metadata: {
          annotations: {
            'ingress.kubernetes.io/ssl-redirect': 'false',
          },
          name: 'blog',
          namespace: 'blog',
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
                        name: 'blog',
                        port: {
                          number: 1313,
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
          namespace: 'blog',
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
