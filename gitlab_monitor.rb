require 'gitlab'
require_relative 'notification'
require_relative 'notification_executor'

Gitlab.configure do |config|
  config.endpoint       = 'https://wrgitlab.int.net.nokia.com/api/v3'
  config.private_token  = 'LZUyh46BiRkypCzUDyFw'
end

Gitlab.http_proxy('10.144.1.10', 8080)

@project_id = 1375

opened_mrs = Gitlab.merge_requests(1375, state: :opened)

notifier = NotificationExecutor.new
notifier.execute(Notification.new("Lol2", "Zobacz to ziom!", "http://kde.org/", "dialog-information"))