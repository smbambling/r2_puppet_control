# == Overview: R2 Management
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:

class role::r2 {

  contain profile::base
  contain profile::local_firewall
  contain profile::plex_media_server
  contain profile::apache
  contain profile::bambling_org
  contain profile::techtaco_org

  Class['profile::base'] ->
  Class['profile::local_firewall'] ->
  Class['profile::apache'] ->
  Class['profile::bambling_org'] ->
  Class['profile::techtaco_org'] ->
  Class['profile::plex_media_server']

}
