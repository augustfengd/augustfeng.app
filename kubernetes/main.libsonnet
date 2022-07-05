local blog = import 'applications/blog.libsonnet';
local certManager = import 'applications/certManager.libsonnet';
local example = import 'applications/example.libsonnet';
local huginn = import 'applications/huginn.libsonnet';
local transfersh = import 'applications/transfersh.libsonnet';

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
    transfersh: {},
    huginn+: {
      credentials+: {
        admin+:: {  // TODO: not implemented yet.
          //          local c = import 'secrets/huginn-credentials.json',
          username: 'admin',  // c.user
          password: 'password',  // c.password
        },
      },
      postgresql+: {
        credentials: {
          admin: {
            local c = import 'secrets/postgresql-credentials.json',
            user: c.user,
            password: c.password,
          },
          huginn: {
            local c = import 'secrets/postgresql-credentials-huginn.json',
            user: c.user,
            password: c.password,
          },
        },
      },
    },
  },

  blog: blog($.values.example),
  certManager: certManager($.values.certManager),
  example: example($.values.example),
  transfersh: transfersh($.values.transfersh),
  huginn: huginn($.values.huginn),
}
