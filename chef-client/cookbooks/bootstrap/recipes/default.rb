#
# Cookbook:: bootstrap
# Recipe:: default
#
# Copyright:: 2018, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

node.override['patching']['timing'] = 'manual'
node.override['patching']['patchlevel'] = 1
node.override['patching']['sles']['repositories'] = []

include_recipe 'patching::default'
include_recipe 'time::default'

# Packages
if node['platform_family'] == 'suse' && node['platform_version'].to_f > 12.0
  include_recipe 'bootstrap::packages_sles12'
end

# Services
if node['platform_family'] == 'suse' && node['platform_version'].to_f > 12.0
  include_recipe 'bootstrap::services_sles12'
end

# Applications
if node['platform_family'] == 'suse' && node['platform_version'].to_f > 12.0
  include_recipe 'bootstrap::applications_sles12'
end

# Applications
if node['platform_family'] == 'windows'
  include_recipe 'bootstrap::applications_sles12'
end
