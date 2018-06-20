cookbook_file '/etc/cron.hourly/logrotate' do
  source 'logrotate'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[cron]', :delayed
end

service 'cron' do
  action [ :enable, :start ]
end
