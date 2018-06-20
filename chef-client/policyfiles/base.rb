# Policyfile.rb - Describe how you want Chef to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name "base"

# Where to find external cookbooks:
default_source :supermarket
default_source :chef_repo, "../" do |s|
  s.preferred_for "applications", "user_shadow", "bootstrap"
end

# Temporary, issues on windows habitat package
cookbook 'habitat'
cookbook 'fb_sysctl'
cookbook 'ntp'
cookbook 'audit'

# run_list: chef-client will run these recipes in the order specified.
run_list ["patching::default",
          "hardening::default",
          "applications::default"]

named_run_list "bootstrap", "bootstrap::default"
# in production add: "applications::caf"

default['auth'] = { }

default['compliance'] = {
    'reporter' => ['chef-automate'],
    'server' => 'https://a2demo.jonliv.es/api',
    'insecure' => true
}


default['time'] = { }

default['hardening'] = { }

default['patching'] = { }

default['caf']['env']='prod'


default['applications'] = {
  'linux' => {
    'jonlives/compliance' => {
        'version' => '0.1.0/20180618161001',
        'config' => {
          'interval' => 500,
            'profiles' => ["admin@example.com/linux-baseline", "admin@example.com/linux-patch-baseline"],
            'reporter' => {
              'stdout' => false,
              'url' => 'https://a2demo.jonliv.es/data-collector/v0',
              'token' => 'lA27ii96Js_qINv28oBtf0_kiPM=',
              'verify_ssl' => true,
            },
            'compliance' => {
              'server' => 'https://a2demo.jonliv.es',
              'token' => 'lA27ii96Js_qINv28oBtf0_kiPM=',
              'user' => 'admin@example.com',
              'insecure' => false,
              'enterprise' => 'default'
            },
        }
    },
  },
  'windows' => {}
}