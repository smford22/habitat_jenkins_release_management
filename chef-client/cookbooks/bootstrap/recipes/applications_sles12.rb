platform = node['platform'].eql?('windows') ? 'windows' : 'linux'

node['applications'].each_key do |application|
  app_configs = Chef::Mixin::DeepMerge.merge(
    node['applications'][application],
    node['applications'][application][platform] || {}
  )

  hab_package application do
    version app_configs['version']
  end
end
