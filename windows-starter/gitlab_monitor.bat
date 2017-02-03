PATH C:\Ruby23-x64\bin\
pushd %~dp0
chdir /d ..\app
bundle exec ruby gitlab_monitor.rb