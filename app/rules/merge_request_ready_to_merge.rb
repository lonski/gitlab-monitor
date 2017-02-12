#############################################################################
# Monitors upvotes count on merge requests.                                 #
# Generates a notify if any merge request reaches minimum upvotes required  #
# configured in constructor.                                                #
#############################################################################

require_relative '../notification'

module GitlabMonitor
  class MergeRequestReadyToMerge

    def initialize(options = {})
      @upvotes_required = options[:upvotes_required] || 2      
      @already_notified = []
    end

    def run
      notifications = []

      Gitlab.merge_requests(GitlabMonitor.configuration.project_id, state: :opened)
        .select{ |mr| mr.upvotes >= @upvotes_required }
        .select{ |mr| !@already_notified.include?(mr.id) }
        .each do |mr|
          notifications <<
            Notification.new(
              header: 'Merge request ready to merge',
              body: mr.title,
              link: mr.web_url,
              icon: Icon::INFO
            )
          @already_notified << mr.id
      end

      notifications
    end
  end
end