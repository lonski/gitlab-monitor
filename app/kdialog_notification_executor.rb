module GitlabMonitor
  class KDialogNotificationExecutor

    def execute(n) 
      msg =  "<h2>#{n.header}</h2>" +
             "#{n.body.strip}" +
             "<hr>" +
             "#{n.link.gsub(/\s+/, '')}" 

      File.write('/tmp/msg.gitlab', msg)
      `kdialog --textbox /tmp/msg.gitlab 512 256`
      if $?.exitstatus == 0 
        `xdg-open #{n.link}`
      end
    end

  end
end
