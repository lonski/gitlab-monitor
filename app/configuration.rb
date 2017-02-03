module GitlabMonitor

  #Gitlab API URL
  GITLAB_URL        = "<your_gitlab_url>/api/v3"
  #Token generated on Gitlab in Profile Settings > Access Tokens
  ACCESS_TOKEN      = "<enter_your_access_token>"

  PROXY_HOST        = "10.144.1.10"
  PROXY_PORT        = 8080

  #Amount of sleep between executing rules
  POOL_INTERVAL_SEC = 10

  #Monitored project id
  PROJECT_ID        = 1375
  #Monitored project URL
  PROJECT_URL       = '<your_gitlab_url>/<your_project_name>'
  #Implementation of class responsible for showing notifications in system
  NOTIFIER          = LinuxNotificationExecutor.new(timeout_ms: 1000 * 60 * 60)

  RULES = [
    #Monitors if any merge request is ready to be merged
    MergeRequestReadyToMerge.new(upvotes_required: 2),
    #Monitors if any pipeline of selected branch has failed
    PipelineFailed.new(branches: ['develop', 'master']),
    #Notifies about newly created merge requests
    NewMergeRequest.new
  ]

end
