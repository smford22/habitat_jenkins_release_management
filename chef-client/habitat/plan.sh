if [ -z ${CHEF_POLICYFILE+x} ]; then
  echo "You must set CHEF_POLICYFILE to a policyfile name."
  echo
  echo "For example: env CHEF_POLICYFILE=base build"
  exit 1
fi

scaffold_policy_name="$CHEF_POLICYFILE"
pkg_name=chef-base
pkg_origin=jonlives
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The Chef $scaffold_policy_name Policy"
pkg_upstream_url="http://chef.io"
pkg_scaffolding="core/scaffolding-chef"
pkg_svc_user=("root")