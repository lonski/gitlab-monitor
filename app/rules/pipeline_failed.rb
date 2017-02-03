#############################################################################
# Monitors project pipelines for failures.                                  #
# Pools last 10 pipelines for each defined branch and checks if any failed, #
# if yes, then a notification is generated                                  #
#############################################################################

require_relative '../notification'

module GitlabMonitor
  class PipelineFailed

    def initialize(options = {})
      @branch = options[:branches] || ['develop']
      @already_notified = []
    end

    def run
      notifications = []

      Gitlab.pipelines(PROJECT_ID, per_page: 10)
        .select{ |p| @branch.include?(p.ref)  }
        .select{ |p| p.status == 'failed' }
        .select{ |mr| !@already_notified.include?(mr.id) }
        .each do |p|
           notifications <<
            Notification.new(
              header: 'Pipeline failed',
              body: "Ran by <b>#{p.user.name}</b> on branch <i>#{p.ref}</i>",
              link: "#{PROJECT_URL}/pipelines/#{p.id}",
              icon: Icon::ERROR
            )
          @already_notified << p.id
      end

      notifications
    end
  end
end