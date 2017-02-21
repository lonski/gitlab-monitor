module GitlabMonitor
  GitlabMonitor.configure do |config|
    #Gitlab API URL
    config.gitlab_url        = 'https://wrgitlab.int.net.nokia.com'
    config.gitlab_api_suffix = '/api/v3'
    #Token generated on Gitlab in Profile Settings > Access Tokens
    config.access_token      = 'Cw7LTQNpKJ3To1hWkz4d'

    #Set it to false if you have problem with secure connection (for example ssl certificate problems)
    config.use_ssl           = true

    #Proxy configuration. Leave proxy host blank if none.
    config.proxy_host        = '10.144.1.10'
    config.proxy_port        = 8080

    #Amount of sleep between executing rules
    config.pool_interval_sec = 10

    #Name of the project, visible on address bar:
    #"https://<gitlab_url>/<project_namespace>/<project_name>"
    config.project_name      = 'codeine'

    #Project namespace is the project owning user or group:
    #"https://<gitlab_url>/<project_namespace>/<project_name>"
    config.project_namespace = 'data-platforms'

    #Implementation of class responsible for showing notifications in system. Specify hide timeout [s].
    #You can use equations like 60*5 -> 5 minutes
    config.notification_timeout  = 5
    config.simple_html       = true

    config.rules = [
#      #Monitors if any merge request is ready to be merged
#      MergeRequestReadyToMerge.new(upvotes_required: 2),
#      #Monitors if any pipeline of selected branch has failed
#      PipelineFailed.new(branches: ['develop', 'master']),
#      #Notifies about newly created merge requests
#      NewMergeRequest.new,
#      #Notifies when opened merge request upvotes count raises
#      MergeRequestUpvoted.new,
#      #Notifies about new comments.
#      #params:
#      #  mr_authors - filter MR by authors
#      #  skip_comment_authors - filter comments by authors
#      #  subscribed_only - filter only MR to which you are subscribed
#      NewMergeRequestComment.new(skip_comment_authors: ['Adrian Sitko'], subscribed_only: true)
      DummyRule.new
    ]
  end
end
