local upstream = std.parseYaml(importstr 'install.yaml');
local utils = import 'utils.libsonnet';

function(fqdn='argocd.home.arpa')
  local build = utils.consume(upstream)

                // add manifests
                + utils.builder.addIngress(fqdn)
                + utils.builder.addAppProject(name='services', namespace='*', repository='*')

                // configure argocd server for kubernetes ingress controller with tls termination
                + utils.builder.argocdServerArgsOverride(['argocd-server', '--insecure'])

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
                  name: 'download-cue',
                  image: 'alpine',
                  command: ['sh', '-c'],
                  args: ['wget -qO- https://github.com/cue-lang/cue/releases/download/v0.6.0/cue_v0.6.0_linux_amd64.tar.gz | tar xzf - -C /custom-tools/ cue'],
                  volumeMounts: [{ mountPath: '/custom-tools/', name: 'custom-tools' }],
                })
                // install cue
                + utils.builder.argocdRepoServerContainerVolumeMountsAdd({
                  mountPath: '/usr/local/bin/cue',
                  name: 'custom-tools',
                  subPath: 'cue',
                });

  utils.render(build.manifests)
