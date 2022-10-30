{
  // Copy upstream kubernetes manifests into 'manifests' field for eventual mixins.
  consume(upstream=[])::
    { manifests:: upstream },

  // Render kubernetes manifests for '-m' usage.
  render(manifests)::
    local name(manifest) =
      local kind = manifest.kind;
      local name = manifest.metadata.name;

      if kind != 'CustomResourceDefinition' then
        kind + '.' + name + '.json'
      else
        'crds/' + name + '.json';

    {
      [name(manifest)]: manifest
      for manifest in manifests
    },

  // Library of generic mixin functions for transforming objects
  mixins:: {
    overrideContainerCommand(containerName, command):: {
      spec+: {
        template+: {
          spec+: {
            containers: std.map(function(container)
              if container.name == containerName then container { command: command }
              else
                container, super.containers),
          },
        },
      },
    },

    addContainerEnvironmentVariable(containerName, envVar):: {
      spec+: {
        template+: {
          spec+: {
            containers: std.map(function(container)
              if container.name == containerName then container { env+: [envVar] }
              else
                container, super.containers),
          },
        },
      },
    },

    addContainerVolumeMount(containerName, volumeMount):: {
      spec+: {
        template+: {
          spec+: {
            containers: std.map(function(container)
              if container.name == containerName then container { volumeMounts+: [volumeMount] }
              else
                container, super.containers),
          },
        },
      },
    },

    addInitContainer(container):: {
      spec+: { template+: { spec+: { initContainers+: [container] } } },
    },

    addVolume(volume):: {
      spec+: { template+: { spec+: { volumes+: [volume] } } },
    },
  },

  // builder for applying mixins on manifests.
  builder:: {
    argocdServerCommandOverride(command=['argocd-server']):: {
      manifests: std.map(function(manifest)
        if (manifest.kind == 'Deployment' && manifest.metadata.name == 'argocd-server') then
          manifest + $.mixins.overrideContainerCommand('argocd-server', command)
        else
          manifest, super.manifests),
    },

    argocdRepoServerVolumeAdd(volume):: {
      manifests: std.map(function(manifest)
        if (manifest.kind == 'Deployment' && manifest.metadata.name == 'argocd-repo-server') then
          manifest + $.mixins.addVolume(volume)
        else
          manifest, super.manifests),
    },

    argocdRepoServerInitContainersAdd(container):: {
      manifests: std.map(function(manifest)
        if (manifest.kind == 'Deployment' && manifest.metadata.name == 'argocd-repo-server') then
          manifest + $.mixins.addInitContainer(container)
        else
          manifest, super.manifests),
    },

    argocdRepoServerContainerVolumeMountsAdd(volumeMount):: {
      manifests: std.map(function(manifest)
        if (manifest.kind == 'Deployment' && manifest.metadata.name == 'argocd-repo-server') then
          manifest + $.mixins.addContainerVolumeMount('argocd-repo-server', volumeMount)
        else
          manifest, super.manifests),
    },

    argocdRepoServerContainerEnvironmentVariableAdd(envVar):: {
      manifests: std.map(function(manifest)
        if (manifest.kind == 'Deployment' && manifest.metadata.name == 'argocd-repo-server') then
          manifest + $.mixins.addContainerEnvironmentVariable('argocd-repo-server', envVar)
        else
          manifest, super.manifests),
    },

    addIngress(fqdn):: {
      local IngressRouteObject = {
        apiVersion: 'traefik.containo.us/v1alpha1',
        kind: 'IngressRoute',
        metadata: {
          name: 'argocd-server',
          namespace: 'argocd',
        },
        spec: {
          entryPoints: ['websecure'],
          routes: [
            {
              kind: 'Rule',
              match: 'Host(`%s`)' % fqdn,
              priority: 10,
              services: [{
                name: 'argocd-server',
                port: 80,
              }],
            },
            {
              kind: 'Rule',
              match: 'Host(`%s`) && Headers(`Content-Type`, `application/grpc`)' % fqdn,
              priority: 101,
              services: [{
                name: 'argocd-server',
                port: 80,
                scheme: 'h2c',
              }],
            },
          ],
          tls: { secretName: fqdn },
        },
      },
      local CertificateObject = {
        apiVersion: 'cert-manager.io/v1',
        kind: 'Certificate',
        metadata: {
          name: 'argocd-server',
          namespace: 'argocd',
        },
        spec: {
          dnsNames: [fqdn],
          secretName: fqdn,
          issuerRef: {
            name: 'letsencrypt',  // NOTE: opinionated hardcode.
            kind: 'ClusterIssuer',
          },
        },
      },
      manifests+: [IngressRouteObject, CertificateObject],
    },

    addSecret(secretName, data):: {
      local secretObject = {
        apiVersion: 'v1',
        kind: 'Secret',
        metadata: {
          name: secretName,
          namespace: 'argocd',
        },
        data: data,
      },
      manifests+: [secretObject],
    },

    addAppProject(name, namespace, repository):: {
      local appProjectObject = {
        apiVersion: 'argoproj.io/v1alpha1',
        kind: 'AppProject',
        metadata: {
          name: name,
          namespace: 'argocd',
        },
        spec: {
          // NOTE: required by Pull Request Generator (ApplicationSet) to manage namespace.
          clusterResourceWhitelist: [{
            group: '',
            kind: 'Namespace',
          }],
          destinations: [{ name: 'in-cluster', namespace: namespace, server: 'https://kubernetes.default.svc' }],
          sourceRepos: [repository],
        },
      },
      manifests+: [appProjectObject],
    },

    argocdServerClusterRoleAdd(rule):: {
      manifests: std.map(function(manifest)
        if (manifest.kind == 'ClusterRole' && manifest.metadata.name == 'argocd-server') then
          manifest { rules+: [rule] }
        else
          manifest, super.manifests),
    },

    argocdCmSet(key, value):: {
      manifests: std.map(function(manifest)
        if (manifest.kind == 'ConfigMap' && manifest.metadata.name == 'argocd-cm') then
          manifest { data+: { [key]: value } }
        else
          manifest, super.manifests),
    },

    addLocalUser(name, capabilities):: {
      manifests: std.map(function(manifest)
        if (manifest.kind == 'ConfigMap' && manifest.metadata.name == 'argocd-cm') then
          manifest { data+: { ['accounts.%s' % name]: std.join(',', capabilities) } }
        else
          manifest, super.manifests),
    },

    addRbac(line):: {
      manifests: std.map(function(manifest)
        if (manifest.kind == 'ConfigMap' && manifest.metadata.name == 'argocd-rbac-cm') then
          manifest { data+: { 'policy.csv'+: '%s\n' % line } }
        else
          manifest, super.manifests),
    },

    addPlugins:: {
      local cue = {
        name: 'cue',
        init: {
          command: ['true'],
          args: [''],
        },
        generate: {
          command: ['true'],
          args: [''],
        },
      },
      local pluginYamlStr = std.toString(std.manifestYamlDoc([cue])),
      manifests: std.map(function(manifest)
        if (manifest.kind == 'ConfigMap' && manifest.metadata.name == 'argocd-cm') then
          manifest { data+: { configManagementPlugins: pluginYamlStr } }
        else
          manifest, super.manifests),
    },
  },
}
