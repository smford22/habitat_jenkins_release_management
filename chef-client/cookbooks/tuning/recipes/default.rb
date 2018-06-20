#
# Cookbook:: tuning
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

node.default['fb_sysctl'] = {}

if platform_family?('suse')
  if node['tuning']
    node.override['fb_sysctl'] = node['tuning']['sles']
    include_recipe "fb_sysctl::default"
  end
end
