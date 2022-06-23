local utils = import 'utils.libsonnet';
local upstream = std.parseYaml(importstr 'upstream/cert-manager.yaml');

function(params={}) utils.applicationize(utils.dehelminize(upstream)) + {}
