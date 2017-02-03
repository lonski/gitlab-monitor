# Gitlab monitor

Monitors gitlab project and show system notifications when an event occurs

![](screen1.png)

## Installation

* Ruby interpreter

Install ruby interpreter. For linux use RVM, for windows RubyInstaller.

* Bundler

Make sure you have bundler gem installed:

```sh
gem install bundler
```

* Dependencies installation

Enter gitlab_notify/app directory and install dependencies:

*Linux:* 
```sh
bundle install --without windows
```

*Windows:*
```sh
bundle install --without linux
```

* Running Gitlab Monitor

To manualy run gitlab monitor:

```sh
bundle exec ruby gitlab_monitor.rb
```

## Systemd service (Linux only)

Copy service file to user services directory:

```sh
cp systemd-service/gitlab_monitor.service ~/.config/systemd/user
```

Replace `GITLAB_MONITOR_DIR` with gitlab_monitor location:

```sh
sed -i -- 's?GITLAB_MONITOR_DIR?'`pwd`'?g' ~/.config/systemd/user/gitlab_monitor.service
```

Enable service:

```sh
systemctl --user enable gitlab_monitor
```

## Configuration

Edit file `app/configuration.rb`
