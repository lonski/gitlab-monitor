require_relative '../notification'

module GitlabMonitor
  class NewMergeRequestComment

    def initialize(options = {})
      @authors = options[:mr_authors] || []
      @skip_comment_authors = options[:skip_comment_authors] || []
      @subscribed_only = options[:subscribed_only] || false
      @comments_known = []
    end

    def run
      notifications = []

      Gitlab.merge_requests(PROJECT_ID, state: :opened)
        .select{ |mr| @authors.include?(mr.author.name) || @authors.empty? }
        .select{ |mr| (@subscribed_only && mr.subscribed) || !@subscribed_only }
        .each do |mr|
          Gitlab.merge_request_notes(PROJECT_ID, mr.id)          
            .select{|n| !@comments_known.include?(n.id) }
            .select{|n| !@skip_comment_authors.include?(n.author.name) }            
            .each do |n|              
              notifications <<
                Notification.new(
                  header: 'New comment',
                  body: "On <i>#{mr.title}</i> by #{n.author.name}: <br/>'<i>#{n.body}</i>'",
                  link: mr.web_url,
                  icon: Icon::INFO
                )
              @comments_known << n.id
          end
      end

      notifications
    end
  end
end