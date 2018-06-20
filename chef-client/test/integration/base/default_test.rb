# # encoding: utf-8

# Inspec test for recipe patching::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if os.suse?
  describe file('/etc/zypp/repos.d/packman.repo') do
    it { should exist }
  end
end

describe file('/hab/svc/chef-base/data/cache/cache/chef_patching_sentinel') do
  it { should exist }
end
