module GitlabMonitor

  module Icon
    INFO  = 'info'
    WARN  = 'warn'
    ERROR = 'error'
  end

  class Notification
    
    VALID_OPTIONS_KEYS = [:header, :body, :icon, :link].freeze
    attr_accessor(*VALID_OPTIONS_KEYS) 

    def initialize(options = {})
      VALID_OPTIONS_KEYS.each do |key|
          send("#{key}=", options[key]) if options[key]
      end
    end

    def generate_html_body()
      "#{body}<br><a href='#{link}'>View on Gitlab</a>"
    end
  end
end
