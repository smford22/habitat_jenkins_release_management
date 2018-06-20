delivery_fqdn "a1.scottford.io"
delivery['chef_username'] = "delivery"
delivery['chef_private_key'] = "/etc/delivery/delivery.pem"
delivery['chef_server'] = "https://chef.scottford.io/organizations/automate"
insights['enable'] = true
delivery['ssl_certificates'] = {
  'a1.scottford.io' => {
    'key' => 'file:///etc/ssl_certificates/a1.key',
    'crt' => 'file:///etc/ssl_certificates/a1.crt'
  }
}