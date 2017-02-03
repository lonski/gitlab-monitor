module GitlabMonitor
	class WindowsNotificationExecutor
	  def initialize(options = {})
	  	@options = options
	  	@options[:type] ||= :info
	  	@options[:time] ||= 5 #seconds
	  end

	  def execute(n)  
	  	require 'rb-notifu'
	  	require 'launchy'

	  	@options[:title] = n.header
	  	@options[:message] = strip_html_tags(n.body)
      @options[:type] = n.icon

	    Notifu::show @options do |s|
			Launchy.open(n.link) if s == 3 
	    end
	  end

	  private
	  	def strip_html_tags(str)
	  		str.gsub(/<\/?[^>]*>/, "")
	  	end
	end
end