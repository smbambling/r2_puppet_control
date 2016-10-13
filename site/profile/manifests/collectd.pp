# == Overview: Install and Configure CollectD 
#
# == Requirements:
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:

class profile::collectd (
  $graphitehost   = hiera("profile::graphite::virtualhost"),
  $graphiteport   = '2003',
  $graphiteprefix = 'collectd.',
){

  include yumrepo::collectd_ci

}
