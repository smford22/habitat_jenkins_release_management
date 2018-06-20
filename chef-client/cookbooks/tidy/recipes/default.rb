#
# Cookbook:: tidy
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

if node['platform_family'] == 'suse' && node['platform_version'].to_f > 12.0
  include_recipe 'tidy::sles12'
end