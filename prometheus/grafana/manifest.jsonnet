local kpm = import "kpm.libjsonnet";

function(
   params={}
)

kpm.package({
  package: {
         name: "prometheus/grafana",
         expander: "jinja2",
         author: "Antoine Legrand",
         version: "3.1.1-1",
         description: "prom grafana",
         license: "MIT",
      },

      variables: {
         node_port: 30902,
         svc_type: "NodePort",
         image: "grafana/grafana:3.1.1",
         watcher_image: "quay.io/coreos/grafana-watcher:latest"
         },

      resources:
         [{ file: "grafana-cm.yaml",
            name: "grafana-dashboards",
            type: "deployment",
            template:: (importstr "templates/grafana-cm.yaml"),
          },

          { file: "grafana-depl.yaml",
            name: "grafana",
            type: "deployment",
            template:: (importstr "templates/grafana-depl.yaml"),
          },

          { file: "grafana-svc.yaml",
            name: "grafana",
            type: "svc",
            template:: (importstr "templates/grafana-svc.yaml"),
          },
          ],

      deploy: [
        { name: "$self"},
        ]
   }, params)
