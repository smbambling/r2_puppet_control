# == Overview: 'Default' configuration settings that are applied to ALL nodes
#  - Configure Repositories
#    - ARIN 'default' internal repository
#  - Set root useres GECOS field
#
# == Requirements:
#  - bambling/yumrepo  module
#
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:

class profile::base (
  Boolean $monitoring = hiera('base::monitoring', true),
){

  contain yumrepo::epel

  # Set the root user GECOS field in /etc/passwd
  # This variable is called in hieradata/accounts.users.eyaml for root
  $gecos_nodename = $::fqdn

  # Install ZSH Shell
  package { 'zsh':
    ensure => present,
  }

  # Set sexlinux to permissive
  class { selinux:
    mode => 'permissive',
    type => 'permissive',
  }

  # Manage Additional Certificate Authorities
  include ::ca_cert

  # Add SSL PKI Certificates to system
  $sslcerts = hiera_hash(certs_for_system)
  create_resources(sslmgmt::cert, $sslcerts)

  # Add Certificate Authories to system
  $cacerts = hiera_hash(ca_certs_for_system)
  create_resources(sslmgmt::ca_dh, $cacerts)

  # Manage the Mcollective and PXP-Agent Services
  service { ['mcollective','pxp-agent']:
    ensure => stopped,
    enable => false,
  }

  # Manage /etc/sudoers, /etc/sudoers.d and sudo.conf - parameters overridden in hiera
  include ::sudo

  # Make sure includedir is added
  file_line { 'sudo_include':
    path => '/etc/sudoers',
    line => '#includedir /etc/sudoers.d',
  }

  ##########################################
  ## Manage User/Group Accounts via Hiera ##
  ##########################################

  # Manage Groups
  create_resources('@group', hiera_hash('accounts::groups'))
  hiera_hash('managed_groups')[groups].each | $group_name | {
    Group<| title == $group_name |>
  }

  # Manage User Accounts
  create_resources('@accounts::user', hiera_hash('accounts::users'))
  hiera_hash('managed_users')[users].each | $user | {
    Accounts::User<| tag == $user |>
  }

  if $monitoring {
    include ::profile::sensu::client
    include ::profile::collectd
  }

}
