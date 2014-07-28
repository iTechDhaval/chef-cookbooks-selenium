#
# Selenium environment for functional test.
#

#
# Java Installation for selenium server.
#
package node[:selenium][:java_package] do
  action :install
end

# selenium server
cookbook_file node[:selenium][:install_to] + '/' + node[:selenium][:jar] do
  source node[:selenium][:jar]
  owner "root"
  group "root"
  mode "0755"
  not_if "test -e " + node[:selenium][:install_to] + '/' + node[:selenium][:jar]
end

link node[:selenium][:prog_path] do
  to node[:selenium][:install_to] + '/' + node[:selenium][:jar]
end

# init.d script
template "/etc/init.d/selenium" do
  source "init.d/selenium.erb"
  owner "root"
  group "root"
  mode "0755"
end

service "selenium" do
  action [ :disable ]
end

# logrotate
template "/etc/logrotate.d/selenium" do
  source "logrotate.d/selenium.erb"
  owner "root"
  group "root"
  mode "0644"
end

# xorg
list = case node.platform
when "ubuntu" then
  %w(xserver-xorg-core xvfb)
when "centos" then
  %w(xorg-x11-server-Xvfb mesa-libGL)
end

list.each { |pkg| package(pkg) { action :install } }

template "/etc/init.d/xvfb" do
  source "init.d/xvfb.erb"
  owner "root"
  group "root"
  mode "0755"
end

service "xvfb" do
  action [ :disable ]
end

template "/etc/logrotate.d/xvfb" do
  source "logrotate.d/xvfb.erb"
  owner "root"
  group "root"
  mode "0644"
end

service "xvfb" do
  action [:enable, :start]
end

service "selenium" do
  action [:enable, :start]
end

# browser firefox
package "firefox" do
  action :install
  options ("--force-yes")
end

