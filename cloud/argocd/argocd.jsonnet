local upstream = std.parseYaml(importstr 'install.yaml');
local utils = import 'utils.libsonnet';

function(fqdn='example.com', argocdCmpSecrets={ SOPS_AGE_KEY: '' })
  local build = utils.consume(upstream)

                // add manifests
                + utils.builder.addIngress(fqdn)
                + utils.builder.addAppProject(name='cloud', namespace='*', repository='https://github.com/augustfengd/augustfeng.app.git')

                // configure argocd server for kubernetes ingress controller with tls termination
                + utils.builder.argocdServerCommandOverride(['argocd-server', '--insecure'])

                // enable Web-based Terminal
                + utils.builder.argocdCmSet('exec.enabled', 'true')
                + utils.builder.argocdServerClusterRoleAdd({
                  apiGroups: [''],
                  resources: ['pods/exec'],
                  verbs: ['create'],
                })

                // add plugins for cmp
                + utils.builder.addPlugins
                + utils.builder.argocdRepoServerVolumeAdd({
                  emptyDir: {},
                  name: 'custom-tools',
                })
                + utils.builder.argocdRepoServerInitContainersAdd({
                  name: 'download-make',
                  image:
                    local argocdRepoServer =
                      local results = std.filter(function(o)
                                                   if o.kind == 'Deployment' && o.metadata.name == 'argocd-repo-server' then true else false,
                                                 upstream);
                      assert std.length(results) > 0 : "couldn't find argocd-repo-server pod in upstream!";
                      assert std.length(results[0].spec.template.spec.containers) > 0 : "couldn't find argocd-repo-server container in pod!";
                      results[0];
                    argocdRepoServer.spec.template.spec.containers[0].image,
                  command: ['sh', '-c'],
                  args: ['apt update && apt install make && cp /usr/bin/make /custom-tools/'],
                  securityContext: {
                    runAsUser: 0,  // NOTE: need to run container as root order to install make.
                  },
                  volumeMounts: [{ mountPath: '/custom-tools/', name: 'custom-tools' }],
                })
                + utils.builder.argocdRepoServerInitContainersAdd({
                  name: 'download-sops',
                  image: 'alpine',
                  command: ['sh', '-c'],
                  args: ['wget -q https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux.amd64 -O /custom-tools/sops && chmod +x /custom-tools/sops'],
                  volumeMounts: [{ mountPath: '/custom-tools/', name: 'custom-tools' }],
                })
                + utils.builder.argocdRepoServerInitContainersAdd({
                  name: 'download-cue',
                  image: 'alpine',
                  command: ['sh', '-c'],
                  args: ['wget -qO- https://github.com/cue-lang/cue/releases/download/v0.4.3/cue_v0.4.3_linux_amd64.tar.gz | tar xzf - -C /custom-tools/ cue'],
                  volumeMounts: [{ mountPath: '/custom-tools/', name: 'custom-tools' }],
                })
                // install make
                + utils.builder.argocdRepoServerContainerVolumeMountsAdd({
                  mountPath: '/usr/local/bin/make',
                  name: 'custom-tools',
                  subPath: 'make',
                })
                // install sops
                + utils.builder.argocdRepoServerContainerVolumeMountsAdd({
                  mountPath: '/usr/local/bin/sops',
                  name: 'custom-tools',
                  subPath: 'sops',
                })
                // install cue
                + utils.builder.argocdRepoServerContainerVolumeMountsAdd({
                  mountPath: '/usr/local/bin/cue',
                  name: 'custom-tools',
                  subPath: 'cue',
                })

                // add decryption keys used in cmp (sops)
                + utils.builder.addSecret('sops-secrets', { SOPS_AGE_KEY: std.base64(argocdCmpSecrets.SOPS_AGE_KEY) })
                + utils.builder.argocdRepoServerContainerEnvironmentVariableAdd({
                  name: 'SOPS_AGE_KEY',
                  valueFrom: { secretKeyRef: { name: 'sops-secrets', key: 'SOPS_AGE_KEY' } },
                });

  utils.render(build.manifests, apiGroups=['argoproj.io', 'cert-manager.io', 'traefik.containo.us'])
