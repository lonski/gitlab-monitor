#############################################################################
# Monitors upvotes count on merge requests.                                 #
# Generates a notify if upvotes count is greater that last check            #
#############################################################################

require_relative '../notification'

module GitlabMonitor
  class MergeRequestUpvoted

    def initialize(options = {})      
      @upvotes = {}
    end

    def run
      notifications = []

      Gitlab.merge_requests(GitlabMonitor.configuration.project_id, state: :opened)
        .select{ |mr| @upvotes[mr.id] ||= 0; mr.upvotes > @upvotes[mr.id] }        
        .each do |mr|
          notifications <<
            Notification.new(
              header: 'Merge request upvoted',
              body: "<i>'#{mr.title}'</i>' upvoted from <b>#{@upvotes[mr.id]}</b> to <b>#{mr.upvotes}</b>.",
              link: mr.web_url,
              icon: Icon::INFO
            )
          @upvotes[mr.id] = mr.upvotes
      end

      notifications
    end
  end
end