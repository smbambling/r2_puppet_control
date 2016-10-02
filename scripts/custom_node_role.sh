#!/usr/bin/env bash

# Reference Commands·
cmd_list='mkdir'

# Function to check if referenced command exists
cmd_exists() {
  if [ $# -eq 0 ]; then
    echo 'WARNING: No command argument was passed to verify exists'
  fi

  cmd=${1}
  hash "${cmd}" >&/dev/null # portable 'which'
  rc=$?
  if [ "${rc}" != "0" ]; then
    echo "${cmd} command not found"
    exit 1
  #else
  #  echo "Found: ${cmd} at ${cmd_fullpath}"
  fi
}

# Verify that referenced commands exist on the system
for cmd in ${cmd_list}; do
  cmd_exists "$cmd"
done

fact_file='/opt/puppetlabs/facter/facts.d/custom_node_role.txt'

if [ ! -f "${fact_file}" ]; then
  # Create facter facts.d directory structure
  mkdir -p /opt/puppetlabs/facter/facts.d/

  # Create custom_node_role fact on file system
  echo "custom_node_role=${1}" > "${fact_file}"
fi
