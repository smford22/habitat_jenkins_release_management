$pkg_name="chef-$env:CHEF_POLICYFILE"
$pkg_origin="mwrock"
$pkg_version="0.1.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=("Apache-2.0")
$pkg_build_deps=@("core/chef-dk", "core/git")
$pkg_deps=@("core/chef-dk", "core/cacerts")
$pkg_description="A Chef Policy for $env:CHEF_POLICYFILE"
$pkg_upstream_url="http://chef.io"

function Invoke-Build {
  Remove-Item "$PLAN_CONTEXT/../policyfiles/*.lock.json" -Force
  $policyfile="$PLAN_CONTEXT/../policyfiles/$env:CHEF_POLICYFILE.rb"
  Get-Content $policyfile | ? { $_.StartsWith("include_policy") } | % {
      $first = $_.Split()[1]
      $first = $first.Replace("`"", "").Replace(",", "")
      chef install "$PLAN_CONTEXT/../policyfiles/$first.rb"
  }
  chef install $policyfile
}

function Invoke-Install {
  chef export "$PLAN_CONTEXT/../policyfiles/$env:CHEF_POLICYFILE.lock.json" $pkg_prefix
  Add-Content "$pkg_prefix/.chef/config.rb" -Value @"
cache_path "$($ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($pkg_svc_data_path).Replace("\","/"))"
data_collector.token "lvO4yKH_6MUy5SoF1vvTk34FQkA="
data_collector.server_url "https://a2.jonliv.es/data-collector/v0"
ENV['PSModulePath'] += "C:/Program\ Files/WindowsPowerShell/Modules"
ssl_verify_mode :verify_none
"@
}
