require_relative '../notification'

module GitlabMonitor
  class PipelineFailed

    def initialize(options = {})
      @branch = options[:branch] || 'develop'
      @already_notified = []
    end

    def run
      notifications = []

      Gitlab.pipelines(PROJECT_ID, per_page: 30)
        .select{ |p| p.ref == @branch }
        .select{ |p| p.status == 'failed' }
        .select{ |mr| !@already_notified.include?(mr.id) }
        .each do |p|
           notifications <<
            Notification.new(
              header: 'Pipeline failed',
              body: "Ran by <b>#{p.user.name}</b> on branch <i>#{@branch}</i>",
              link: "#{PROJECT_URL}/pipelines/#{p.id}",
              icon: 'dialog-error'
            )
          @already_notified << p.id
          puts p.web_url
      end

      notifications
    end
  end
end