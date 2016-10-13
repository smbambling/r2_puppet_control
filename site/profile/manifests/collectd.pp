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

  # Install Collectd
  class { '::collectd':
    purge           => true,
    recurse         => true,
    purge_config    => true,
    minimum_version => '5.5',
    interval        => '60',
  }

  # Setup logging for Colletd
  class { 'collectd::plugin::logfile':
    log_level => 'warning',
    log_file  => '/var/log/collected.log'
  }

  # Configure Logrotate for collectd
  logrotate::rule { 'collectd':
    ensure        => present,
    path          => '/var/log/collected.log',
    rotate        => '5',
    rotate_every  => 'day',
    dateext       => true,
    compress      => true,
    delaycompress => true,
    ifempty       => false,
    missingok     => true,
    size          => '500M',
  }

  # Set the Graphite writer output
  collectd::plugin::write_graphite::carbon { $graphitehost:
    graphitehost   => $graphitehost,
    graphiteport   => $graphiteport,
    graphiteprefix => $graphiteprefix,
    protocol       => 'tcp'
  }

  # Collectd Plugins
  class { 'collectd::plugin::cpu':
    reportbystate    => true,
    reportbycpu      => true,
    valuespercentage => true,
  }

  class { 'collectd::plugin::load': }

  class { 'collectd::plugin::memory': }

  class { 'collectd::plugin::swap':
    reportbydevice => false,
    reportbytes    => true,
  }

  class {'collectd::plugin::uptime': }

  class {'collectd::plugin::users': }

  class { 'collectd::plugin::df':
    mountpoints    => ['/u'],
    fstypes        => ['tmpfs','autofs','gpfs','proc','devpts'],
    ignoreselected => true,
  }

  class { 'collectd::plugin::lvm': }

  class { 'collectd::plugin::disk':
    disks          => ['/^dm/'],
    ignoreselected => true,
    udevnameattr   => 'DM_NAME',
  }

  class { 'collectd::plugin::interface':
    interfaces     => ['lo'],
    ignoreselected => true,
  }

  class { 'collectd::plugin::ntpd':
    host           => 'localhost',
    port           => 123,
    reverselookups => false,
    includeunitid  => false,
  }

  class { 'collectd::plugin::processes':
    process_matches => [
      {
      name  => 'process-all',
      regex => 'process.*',
      }
    ],
  }

}
