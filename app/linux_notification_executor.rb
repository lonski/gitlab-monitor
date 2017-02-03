class LinuxNotificationExecutor
  def initialize(options = {})
    @timeout = options[:timeout_ms] || 0
    require 'gir_ffi'
    GirFFI.setup :Notify
    Notify.init("Gitlab Monitor")
  end

  def execute(n)    
    hello = Notify::Notification.new(n.header, n.generate_html_body, n.icon)
    hello.timeout = @timeout
    hello.show
  end
end