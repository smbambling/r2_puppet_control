# == Overview: Local Firewall 'Post'
#
# == Requirements:
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:

class profile::local_firewall::post (
  Boolean $monitoring = hiera('profile::local_firewall::post', true),
){

 firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }

}
