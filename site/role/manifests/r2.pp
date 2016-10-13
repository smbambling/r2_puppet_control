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
  contain profile::bambling_org::main
  contain profile::techtaco_org::main
  contain profile::techtaco_org::kb
  contain profile::graphite
  contain profile::grafana

  Class['profile::base'] ->
  Class['profile::local_firewall'] ->
  Class['profile::apache'] ->
  Class['profile::bambling_org::main'] ->
  Class['profile::techtaco_org::main'] ->
  Class['profile::techtaco_org::kb'] ->
  Class['profile::graphite'] ->
  Class['profile::grafana'] ->
  Class['profile::plex_media_server']

}
