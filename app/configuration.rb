module GitlabMonitor

  #Gitlab API URL
  GITLAB_URL        = "<your_gitlab_url>/api/v3"
  #Token generated on Gitlab in Profile Settings > Access Tokens
  ACCESS_TOKEN      = "<enter_your_access_token>"

  USE_SSL           = true
  PROXY_HOST        = ""
  PROXY_PORT        = 8080

  #Amount of sleep between executing rules
  POOL_INTERVAL_SEC = 10

  #Monitored project id (you can find is in address bar)
  PROJECT_ID        = 666
  #Monitored project URL - used by some rules to construct valid link
  PROJECT_URL       = '<your_gitlab_url>/<your_project_name>'
  #Implementation of class responsible for showing notifications in system. Specify hide timeout [s].
  NOTIFIER          = (RbConfig::CONFIG['host_os'].match(/mswin|windows/i) ? WindowsNotificationExecutor : LinuxNotificationExecutor).new(time: 5)

  RULES = [
    #Monitors if any merge request is ready to be merged
    MergeRequestReadyToMerge.new(upvotes_required: 2),
    #Monitors if any pipeline of selected branch has failed
    PipelineFailed.new(branches: ['develop', 'master']),
    #Notifies about newly created merge requests
    NewMergeRequest.new,
    #Notifies when opened merge request upvotes count raises
    MergeRequestUpvoted.new,
    #Notifies about new comments.
    #params:
    #  mr_authors - filter MR by authors
    #  skip_comment_authors - filter comments by authors
    #  subscribed_only - filter only MR to which you are subscribed
    NewMergeRequestComment.new(skip_comment_authors: ['Lonski Michal'], subscribed_only: true)
    #DummyRule.new
  ]

end
