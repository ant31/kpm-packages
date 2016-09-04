{
  pv_count: 10,
  volumes: [{
    name: "%s" % name,
    storage: {
      hostPath: { path: "/pv/pv%s" % name } },
  } for name in std.range(1, self.pv_count)
  ],
}
