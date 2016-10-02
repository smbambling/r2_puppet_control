#!/usr/bin/env bash
# Install Puppet-Agent 4.x

set -e

if [ "$EUID" -ne "0" ] ; then
  echo "Script must be run as root." >&2
  exit 1
fi

if which puppet > /dev/null ; then
  echo "Puppet is already installed"
  exit 0
fi

if [ ! -f /root/repos_added.txt ]; then
  echo "Installing PuppetLabs Repository"
  sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
else
  echo "Puppet Repostiroy Already Added"
fi

if [ ! -f /root/puppet_agent_installed.txt ]; then
  echo "Installing Puppet-Agent Puppet 4.x"
  sudo yum -y install puppet-agent
else
  echo "Puppet is already installed"
fi
