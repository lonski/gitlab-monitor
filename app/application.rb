
module GitlabMonitor
  class << self
    attr_accessor :configuration, :notifier, :rules
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
    self.notifier = configuration.notifier
    self.rules = configuration.rules
  end

  class Configuration
    attr_accessor :gitlab_url, :gitlab_api_suffix, :access_token, :use_ssl, 
                  :proxy_host, :proxy_port, :pool_interval_sec, 
                  :project_id, :project_url, :notifier, :rules,
                  :project_name, :project_namespace, :link_enabled
  end

  def self.start

    puts \
    "  ____ _ _   _       _       __  __             _ _             \n" \
    " / ___(_) |_| | __ _| |__   |  \\/  | ___  _ __ (_) |_ ___  _ __ \n" \
    "| |  _| | __| |/ _` | '_ \\  | |\\/| |/ _ \\| '_ \\| | __/ _ \\| '__|\n" \
    "| |_| | | |_| | (_| | |_) | | |  | | (_) | | | | | || (_) | |   \n" \
    " \\____|_|\\__|_|\\__,_|_.__/  |_|  |_|\\___/|_| |_|_|\\__\\___/|_|   \n" \
    "                                        2017 by Michał Łoński\n\n"

    puts "Applying Gitlab configuration..."
    configure_gitlab_connection
    update_project_info

    #Run all rules, but do not process notifications, to set initial state
    puts "\nInitializing rules..."
    rules.each do |r|
      puts "\t=> #{r.class.name}"
      r.run
    end

    puts "\nMonitor started."
    while true
      rules.each do |rule|
        rule.run.each{ |notification| notifier.execute(notification) }
      end
      sleep(configuration.pool_interval_sec)
    end
    
  end

  def self.configure_gitlab_connection
    puts "\t=> Gitlab URL: #{configuration.gitlab_url}"
    puts "\t=> SSL: #{configuration.use_ssl}"

    Gitlab.configure do |config|
      config.endpoint       = "#{configuration.gitlab_url}/#{configuration.gitlab_api_suffix}"
      config.private_token  = configuration.access_token
      config.httparty = {verify: configuration.use_ssl}
    end

    unless self.configuration.proxy_host.empty?
      puts "\t=> Using proxy: #{configuration.proxy_host}:#{configuration.proxy_port}"
      Gitlab.http_proxy(configuration.proxy_host, configuration.proxy_port)
    end
  end

  def self.update_project_info
    proj = Gitlab.project_search(configuration.project_name)
            .select {|p| p.namespace.path == configuration.project_namespace}

    raise "Project #{configuration.project_namespace}/#{configuration.project_name} not found!" if proj.empty?

    configuration.project_id = proj[0].id
    puts "\t=> Found project id: #{configuration.project_id}"

    configuration.project_url = proj[0].web_url
    puts "\t=> Project url is: #{configuration.project_url}"
  end

end
