local kpm = import "kpm.libjsonnet";

function(
  params={}
)

  kpm.package({
    package: {
      name: "base/persistent-volumes",
      expander: "jinja2",
      author: "Antoine Legrand",
      version: "1.3.0",
      description: "pv",
      license: "MIT",
    },

    spec:: {
      capacity: {
        storage: $.variables.capacity,
        },
        accessModes: $.variables.access_modes,
        persistentVolumeReclaimPolicy: $.variables.policy,
      },

    variables: {
      volumes: [
             {
              name: name,
              storage: {hostPath: {path: "/pv/%s" % name}}
            } for name in ["pv01"]
          ],
      name: "pv",
      capacity: "10Gi",
      access_modes: [
        "ReadWriteOnce",
      ],
      policy: "Recycle",
      spec: $.spec
      ,
    },

    shards: [{
      name: pv.name,
      variables: {
        storage: pv.storage,
        spec: $.spec + self.storage},
    } for pv in $.variables.volumes
    ],

    resources:
      [
        {
          file: "pv.yaml",
          name: $.variables.name,
          type: "pv",
          sharded: true,
          template:: (importstr "templates/pv.yaml"),
        },
      ],

    deploy: [
      {
        name: "$self",
      },
    ],
  }, params)
