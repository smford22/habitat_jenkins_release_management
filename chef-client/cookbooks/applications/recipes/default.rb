#
# Cookbook:: applications
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

platform = node['platform'].eql?('windows') ? 'windows' : 'linux'

apps = Chef::Mixin::DeepMerge.merge(
  node['applications'],
  node['applications'][platform] || {}
)

apps.each_key do |application|
  next unless application.include?('/')

  app_configs = Chef::Mixin::DeepMerge.merge(
    apps[application],
    apps[application][platform] || {}
  )

  hab_package application do
    version app_configs['version']
  end

  hab_service application do
    strategy      'at-once'
    topology      'standalone'
    action        :start
  end

  next unless app_configs['config']

  # => change resource name if a service_group property gets applied to the
  # hab_service resource above
  hab_config "#{application.split('/').last}.default" do
    config(app_configs['config'])
  end
end
