require 'gitlab'

require_relative 'notification'
require_relative 'linux_notification_executor'
require_relative 'windows_notification_executor'

project_root = File.dirname(File.absolute_path(__FILE__))

Dir.glob(project_root + '/rules/*.rb', &method(:require))

require "#{project_root}/application.rb"
require "#{project_root}/configuration.rb"

GitlabMonitor.start
