local kpm = import "kpm.libjsonnet";

function(
  params={}
)

kpm.package({
   package: {
      name: "gitlab/gitlab-runner",
      expander: "jinja2",
      author: "Antoine Legrand",
      version: "1.8.1-1",
      description: "gitlab-runner",
      license: "Apache 2.0",
    },

    variables: {
      token: "runner-token",
      concurrent: 4,
      gitlabci_url: "https://gitlab.com",
      namespace: 'gitlab',
      image: "gitlab/gitlab-runner:latest",
      appname: "gitlab-runner",
    },

    resources: [
      {
        file: "gitlab-runner-dp.yaml",
        template: (importstr "templates/runner-dp.yaml.j2"),
        name: $.variables.appname,
        type: "deployment",
      },

      {
        file: "configmap.yaml",
        template: (importstr "templates/configmap.yaml.j2"),
        name: $.variables.appname,
        type: "service",
      },

      ],


    deploy: [
      {
        name: "$self",
      },
    ],


  }, params)
