#############################################################################
# Dummy rule for testing purposes.                                          #
#############################################################################

require_relative '../notification'

module GitlabMonitor
  class DummyRule

    def initialize(options = {})
    end

    def run
      notifications = []

      notifications <<
        Notification.new(
          header: 'Test header',
          body: "This is a <b>test</b> <i>message</i>.",
          link: "http://github.com",
          icon: Icon::WARN
      )

      notifications
    end
  end
end
