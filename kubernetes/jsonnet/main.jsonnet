local certManager = import 'cert-manager.libsonnet';

{
  values:: {
    certManager: {},
  },

  applications: {
    'cert-manager': certManager($.values.certManager),
  },
}
