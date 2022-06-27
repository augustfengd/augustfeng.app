local utils = import '../utils.libsonnet';
local upstream = std.parseYaml(importstr 'upstream/cert-manager.yaml');

local defaults = {

};

function(params={})
  local config = defaults + params;

  utils.applicationize(utils.dehelminize(upstream)) + {
    Namespace: {
      blog: {
        apiVersion: 'v1',
        kind: 'Namespace',
        metadata: {
          name: 'cert-manager',
        },
      },
    },
    ClusterIssuer: {
      'letsencrypt-augustfengd': {
        apiVersion: 'cert-manager.io/v1',
        kind: 'ClusterIssuer',
        metadata: {
          name: 'letsencrypt-augustfengd',
        },
        spec: {
          acme: {
            disableAccountKeyGeneration: true,
            privateKeySecretRef: {
              name: 'letsencrypt-augustfengd-account',
            },
            server: 'https://acme-v02.api.letsencrypt.org/directory',
            solvers: [
              {
                http01: {
                  ingress: {},
                },
              },
            ],
          },
        },
      },
    },
    Secrets: {
      'letsencrypt-augustfengd-account': {
        apiVersion: 'v1',
        data: {
          'tls.key': std.base64(config.letsencrypt.tlsKey),
        },
        kind: 'Secret',
        metadata: {
          name: 'letsencrypt-augustfengd-account',
          namespace: 'cert-manager',
        },
        type: 'Opaque',
      },
    },
  }
