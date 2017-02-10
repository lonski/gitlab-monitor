require 'gitlab'

require_relative 'notification'
require_relative 'linux_notification_executor'
require_relative 'windows_notification_executor'

require_relative 'rules/merge_request_ready_to_merge'
require_relative 'rules/pipeline_failed'
require_relative 'rules/new_merge_request'
require_relative 'rules/dummy_rule'
require_relative 'rules/merge_request_upvoted'
require_relative 'rules/new_merge_request_comment'

require_relative 'configuration'

module GitlabMonitor

  def self.start

    puts \
    "  ____ _ _   _       _       __  __             _ _             \n" \
    " / ___(_) |_| | __ _| |__   |  \\/  | ___  _ __ (_) |_ ___  _ __ \n" \
    "| |  _| | __| |/ _` | '_ \\  | |\\/| |/ _ \\| '_ \\| | __/ _ \\| '__|\n" \
    "| |_| | | |_| | (_| | |_) | | |  | | (_) | | | | | || (_) | |   \n" \
    " \\____|_|\\__|_|\\__,_|_.__/  |_|  |_|\\___/|_| |_|_|\\__\\___/|_|   \n" \
    "                                        2017 by Michał Łoński\n\n"

    apply_config

    #Run all rules, but do not process notifications, to set initial state
    puts "Initializing rules..."
    RULES.each do |r|
      puts "\t => #{r.class.name}"
      r.run
    end

    puts "\nMonitor started."
    while true
      RULES.each do |rule|
        rule.run.each{ |notification| NOTIFIER.execute(notification) }
      end
      sleep(POOL_INTERVAL_SEC)
    end
    
  end

  private

    def self.apply_config
      puts "Applying Gitlab configuration..."

      puts "\t=> Gitlab URL: #{GITLAB_URL}"
      puts "\t=> SSL: #{USE_SSL}"

      Gitlab.configure do |config|
        config.endpoint       = GITLAB_URL
        config.private_token  = ACCESS_TOKEN
        config.httparty = {verify: USE_SSL}
      end

      unless PROXY_HOST.empty?
        puts "=> Using proxy: #{PROXY_HOST}:#{PROXY_PORT}"
        Gitlab.http_proxy(PROXY_HOST, PROXY_PORT)
      end
    end
end

GitlabMonitor.start


