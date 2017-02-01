class NotificationExecutor
  def initialize()
    require 'gir_ffi'
    GirFFI.setup :Notify
    Notify.init("Gitlab Monitor")
  end

  def execute(n)    
    hello = Notify::Notification.new(n.header, n.generate_html_body, n.icon)
    p hello.show
  end
end

