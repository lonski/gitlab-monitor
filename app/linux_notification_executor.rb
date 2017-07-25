module GitlabMonitor
  class LinuxNotificationExecutor
    def initialize(options = {})
      @timeout = options[:time] * 1000 || 0
      @simple = options[:simple_html]
      require 'gir_ffi'
      GirFFI.setup :Notify
      Notify.init('Gitlab Monitor')
    end

    def execute(n)
      case n.icon
        when Icon::INFO
          icon = 'dialog-information'
        when Icon::WARN
          icon = 'dialog-warning'
        when Icon::ERROR
          icon = 'dialog-error'
      end

      hello = Notify::Notification.new(n.header, @simple ? strip_complex_tags(n.body) : n.generate_html_body, icon)
      hello.timeout = @timeout
      hello.show
    end

    private
      def strip_complex_tags(str)
        str.gsub(/<\/?(?:[^biu]|[^>\/]{2,})\/?>/, '')
      end
  end
end
