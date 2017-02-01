require 'gitlab'
require_relative 'notification'
require_relative 'notification_executor'

require_relative 'rules/merge_request_ready_to_merge'
require_relative 'rules/pipeline_failed'

require_relative 'configuration'

module GitlabMonitor

  def self.start
    apply_config

    while true
      RULES.each do |rule|
        rule.run.each{ |notification| NOTIFIER.execute(notification) }
      end
      sleep(POOL_INTERVAL_SEC)
    end
    
  end

  private

    def self.apply_config
      Gitlab.configure do |config|
        config.endpoint       = GITLAB_URL
        config.private_token  = ACCESS_TOKEN
      end

      Gitlab.http_proxy(PROXY_HOST, PROXY_PORT)
    end
end

GitlabMonitor.start


