# Disable

# Enable
enable_services = %w[
  sssd
  rsyslog
]

enable_services.each do |svc|
  service svc do
    action :enable
  end
end
