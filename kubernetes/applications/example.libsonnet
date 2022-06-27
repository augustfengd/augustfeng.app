local defaults = {
  nginx: {
    fqdn: 'nginx.example.augustfeng.app',
    labels: {
      'app.kubernetes.io/name': 'example',
      'app.kubernetes.io/instance': 'example-nginx',
    },
  },
};

function(params={})
  local config = defaults + params;

  {
    Namespace: {
      example: {
        apiVersion: 'v1',
        kind: 'Namespace',
        metadata: {
          name: 'example',
        },
      },
    },
    Deployment: {
      nginx: {
        apiVersion: 'apps/v1',
        kind: 'Deployment',
        metadata: {
          namespace: 'example',
          name: 'nginx',
        },
        spec: {
          selector: {
            matchLabels: config.nginx.labels,
          },
          template: {
            metadata: {
              labels: config.nginx.labels,
            },
            spec: {
              containers: [
                {
                  name: 'nginx',
                  image: 'nginx',
                  ports: [
                    {
                      containerPort: 80,
                    },
                  ],
                },
              ],
            },
          },
        },
      },
    },
    Service: {
      nginx: {
        apiVersion: 'v1',
        kind: 'Service',
        metadata: {
          namespace: 'example',
          name: 'nginx',
        },
        spec: {
          ports: [
            {
              port: 80,
              targetPort: 80,
            },
          ],
          selector: config.nginx.labels,
        },
      },
    },
    Ingress: {
      nginx: {
        apiVersion: 'networking.k8s.io/v1',
        kind: 'Ingress',
        metadata: {
          annotations: {
            'ingress.kubernetes.io/ssl-redirect': 'false',
          },
          name: 'nginx',
          namespace: 'example',
        },
        spec: {
          rules: [
            {
              host: config.nginx.fqdn,
              http: {
                paths: [
                  {
                    path: '/',
                    pathType: 'Prefix',
                    backend: {
                      service: {
                        name: 'nginx',
                        port: {
                          number: 80,
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
              secretName: '%s-tls' % config.nginx.fqdn,
            },
          ],
        },
      },
    },
    Certificate: {
      ['%s' % config.nginx.fqdn]: {
        apiVersion: 'cert-manager.io/v1',
        kind: 'Certificate',
        metadata: {
          namespace: 'example',
          name: config.nginx.fqdn,
        },
        spec: {
          secretName: '%s-tls' % config.nginx.fqdn,
          dnsNames: [
            config.nginx.fqdn,
          ],
          issuerRef: {
            name: 'letsencrypt-augustfengd',
            kind: 'ClusterIssuer',
          },
        },
      },
    },
  }
