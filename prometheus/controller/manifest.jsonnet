local kpm = import "kpm.libjsonnet";

function(
   params={}
)

kpm.package({
  package: {
         name: "prometheus/controller",
         expander: "jinja2",
         author: "Antoine Legrand",
         version: "1.2.0-1",
         description: "prom controller",
         license: "MIT",
      },

      variables: {
         alertmanager_image: "quay.io/coreos/kube-alertmanager-controller:latest",
         prometheus_image: "quay.io/coreos/kube-prometheus-controller:latest"
         },


      resources:
         [{ file: "alertmanager-controller.yaml",
            name: "alertmanager-controller",
            type: "deployment",
            template:: (importstr "templates/alertmanager-controller.yaml"),
          },
          { file: "prometheus-controller.yaml",
            name: "prometheus-controller",
            type: "deployment",
            template:: (importstr "templates/prometheus-controller.yaml"),
          },
          ],

      deploy: [
        { name: "$self"},
        ]
   }, params)
