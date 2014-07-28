default[:selenium][:java_package] = "openjdk-7-jdk"
default[:selenium][:jar] = "selenium-server-standalone-2.39.0.jar"
case node['platform_family']
  when 'rhel', 'fedora'
    default[:selenium][:install_to] = "/usr/local/libexec"
    default[:selenium][:prog_path] = "/usr/local/libexec/selenium-server-standalone.jar"
else
  default[:selenium][:install_to] = "/usr/local/lib"
  default[:selenium][:prog_path] = "/usr/local/lib/selenium-server-standalone.jar"
end
default[:selenium][:port] = "4444"
default[:selenium][:options] = "-trustAllSSLCertificates"
