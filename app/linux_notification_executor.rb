module GitlabMonitor
  class LinuxNotificationExecutor
    def initialize(options = {})
      @timeout = options[:time] * 1000 || 0
      @simple = options[:simple_html]
      @random = Random.new
      require 'gir_ffi-gtk3'
      Thread.new {
        Gtk::init
        Gtk::main
      }
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
        else
          icon = nil
      end

      body = @simple ? strip_complex_tags(n.body) : n.generate_html_body
      hello = Notify::Notification.new(n.header, body, icon)
      hello.timeout = @timeout
      hello.add_action("link" + @random.rand(8<<32).to_s(32), "View") {
        `xdg-open #{n.link}`
      }
      show_notification(hello)
    end

    private
      def show_notification(hello)
        begin
          hello.show
        rescue RuntimeError => e
          STDERR.puts "Error occurred while showing notification with following body: #{hello.body}"
          STDERR.puts e
        end
      end

      def strip_complex_tags(str)
        str.gsub(/<br\s?\/?>/, "\n").gsub(/<\/?(?:[^biu]|[^>\/]{2,})\/?>/, '')
      end
  end
end
