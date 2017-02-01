module GitlabMonitor

  #Gitlab API URL
  GITLAB_URL        = "https://wrgitlab.int.net.nokia.com/api/v3"
  #Token generated on Gitlab in Profile Settings > Access Tokens
  ACCESS_TOKEN      = "LZUyh46BiRkypCzUDyFw"

  PROXY_HOST        = "10.144.1.10"
  PROXY_PORT        = 8080

  #Amount of sleep between executing rules
  POOL_INTERVAL_SEC = 10

  #Monitored project id
  PROJECT_ID        = 1375
  #Monitored project URL
  PROJECT_URL       = 'https://wrgitlab.int.net.nokia.com/data-platforms/codeine'
  #Implementation of class responsible for showing notifications in system
  NOTIFIER          = LinuxNotificationExecutor.new

  RULES = [
    MergeRequestReadyToMerge.new(upvotes_required: 2),
    PipelineFailed.new(branch: 'feature/decider')
  ]

end