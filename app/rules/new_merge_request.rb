require_relative '../notification'

module GitlabMonitor
  class NewMergeRequest

    def initialize(options = {})
      @last_known = 0
    end

    def run
      notifications = []

      Gitlab.merge_requests(PROJECT_ID, state: :opened)
        .sort_by{ |mr| !mr.id }
        .select{ |mr| mr.id > @last_known }
        .each do |mr|
          notifications <<
            Notification.new(
              header: 'New merge request',
              body: "#{mr.title} by <i>#{mr.author.name}</i>",
              link: mr.web_url,
              icon: Icon::INFO
            )
          @last_known = [@last_known, mr.id].max
      end

      notifications
    end
  end
end