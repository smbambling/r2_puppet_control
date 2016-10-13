# == Overview: Juicebox Management
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:

class role::juicebox {

  contain profile::base
  contain profile::local_firewall
  contain profile::collectd
  contain profile::plex_media_server
  contain profile::apache
  contain profile::graphite
  contain profile::grafana
  contain profile::octavisjones_com::main

  Class['profile::base'] ->
  Class['profile::local_firewall'] ->
  Class['profile::collectd'] ->
  Class['profile::apache'] ->
  Class['profile::graphite'] ->
  Class['profile::grafana'] ->
  Class['profile::octavisjones_com::main'] ->  
  Class['profile::plex_media_server']

}
