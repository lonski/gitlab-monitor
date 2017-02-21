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
          body: "This is a <b>test</b> <u>underlined</u> <i>message</i>.<br/>With a <br>new line.<a href='lolz'>and a link!</a>",
          link: "http://github.com",
          icon: Icon::WARN
      )

      notifications
    end
  end
end
