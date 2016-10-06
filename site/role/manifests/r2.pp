# == Overview: R2 Management
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:

class role::r2 {

  contain profile::base
  contain profile::local_firewall
  contain profile::plex_media_server

  Class['profile::base'] ->
  Class['profile::local_firewall'] ->
  Class['profile::plex_media_server']

}
