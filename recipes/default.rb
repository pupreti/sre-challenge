#
# Cookbook:: sre-challenge
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Apache2 installation and configuration
apt_update
package 'apache2'

my_key_path = node['apache']['key']['path']
my_cert_path = node['apache']['cert']['path']

# there is no need to save the resource in a variable in this case because we
# know the paths
ssl_certificate 'server' do
  key_path my_key_path
  key_mode 0o0640
  cert_path my_cert_path
end

file '/etc/apache2/sites-available/*' do
  action :delete
end

cookbook_file '/etc/apache2/sites-available/apache.conf' do
  source 'apache.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/apache2/sites-available/ssl.conf' do
  source 'ssl.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/apache2/ports.conf' do
  source 'ports.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/var/www/html/index.html' do
  source 'index.html'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

link '/etc/apache2/sites-enabled/apache.conf' do
  to '/etc/apache2/sites-available/apache.conf'
end

link '/etc/apache2/sites-enabled/ssl.conf' do
  to '/etc/apache2/sites-available/ssl.conf'
end

service 'apache2' do
  supports status: true, restart: true, reload: true
  action %i[enable start]
end

# Host based firewall rule configuration

include_recipe 'iptables'

iptables_rule 'http' do
  action :enable
end

 iptables_rule 'https' do
   action :enable
 end

iptables_rule 'ssh' do
  action :enable
end
