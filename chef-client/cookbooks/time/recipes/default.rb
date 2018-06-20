#
# Cookbook:: time
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


node.override['ntp'] = node['time']
include_recipe "ntp::default" unless node['time']['is_active_directory']