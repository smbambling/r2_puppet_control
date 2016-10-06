# == Overview: Manage local firewall settings and rules
#
# == Requirements:
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:

class profile::local_firewall(
  Boolean $monitoring = hiera('profile::local_firewall', true),
){

  ## Profile Specific Monitoring ##
  # Note: ${name} variable is used to get the name of the profile class
  if $monitoring {
    profile::sensu::profile::checks { $name:
      profile_name => $name,
    }
  }

  class { 'firewall':
    ensure => 'stopped',
  }

}

