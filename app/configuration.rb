module GitlabMonitor

  GITLAB_URL        = "https://wrgitlab.int.net.nokia.com/api/v3"
  ACCESS_TOKEN      = "LZUyh46BiRkypCzUDyFw"

  PROXY_HOST        = "10.144.1.10"
  PROXY_PORT        = 8080

  POOL_INTERVAL_SEC = 10

  PROJECT_ID        = 1375
  PROJECT_URL       = 'https://wrgitlab.int.net.nokia.com/data-platforms/codeine'
  NOTIFIER          = LinuxNotificationExecutor.new

  RULES = [
    MergeRequestReadyToMerge.new(upvotes_required: 2),
    PipelineFailed.new(branch: 'feature/decider')
  ]

end