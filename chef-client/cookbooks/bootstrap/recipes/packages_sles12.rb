# Remove
remove_packages = %w[
  systemd-logger
  openldap2
  openldap2-client
  telnet-server
  atftp
  xorg-x11
  rsync
  talk
  ypbind
  rsh
]
remove_packages.each do |pkg|
  package pkg do
    action :remove
  end
end

# Install
install_packages = %w[
  krb5-client
  sssd
  sssd-ad
  samba-client
  rsyslog
]
install_packages.each do |pkg|
  package pkg do
    action :install
  end
end
