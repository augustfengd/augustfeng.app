local blog = import 'applications/blog.libsonnet';
local certManager = import 'applications/certManager.libsonnet';
local example = import 'applications/example.libsonnet';

{
  values:: {
    certManager: {
      namespace: 'cert-manager',  // TODO: hardcoded. need to create mixin objects if want to use across entire application.
      letsencrypt: {
        local secrets = import 'secrets/letsencrypt.json',
        tlsKey: secrets['tls.key'],
      },
    },
    example: {},
    blog: {},
  },

  blog: blog($.values.example),
  certManager: certManager($.values.certManager),
  example: example($.values.example),
}
