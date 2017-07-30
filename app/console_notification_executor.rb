module GitlabMonitor
  class ConsoleNotificationExecutor

    def execute(n) 
      puts
      puts " ===== NOTIFICATION (#{Time.now}) ===== "
      puts " ##### #{n.header}"
      puts 
      puts strip_complex_tags(n.body)
      puts 
      puts " ---------------------------------------------------- "
      puts n.link
      puts " ==================================================== "
      puts
    end

    private
      def strip_complex_tags(str)
        str.gsub(/<\/?(?:[^biu]|[^>\/]{2,})\/?>/, '')
        str.gsub(/<\/?.>/, '')
      end
  end
end
