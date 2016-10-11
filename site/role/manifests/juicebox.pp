# == Overview: Juicebox Management
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:

class role::juicebox {

  contain profile::base
  contain profile::local_firewall
  contain profile::plex_media_server
  contain profile::apache

  Class['profile::base'] ->
  Class['profile::local_firewall'] ->
  Class['profile::apache'] ->
  Class['profile::plex_media_server']

}
