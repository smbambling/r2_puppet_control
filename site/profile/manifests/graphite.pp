# == Overview: Installs and manages Graphite 
#
# == Requirements:
#  - graphite module
#  - memcached module
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:
class profile::graphite (
  Boolean $monitoring = hiera("${name}::monitoring", true),
) {

## Profile Specific Monitoring ##
  # Note: ${name} variable is used to get the name of the profile class
  #  Ex: ${name} = profile::pe::mom
  if $monitoring {
    profile::sensu::profile::checks { $name:
      profile_name => $name,
      require      => Package['cyrus-sasl-devel'], #needed for plugins-memcached
    }
  }

  package { 'cyrus-sasl-devel':
    ensure => 'latest',
  }

  file { '/opt/graphite':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  
  class { '::graphite':
    # We need to set gr_web_server to 'none'
    # because we want to use our _own_ apache manifests
    # rather than have the module manage something else.
    gr_web_server               => 'none',
    gr_web_user                 => 'apache',
    gr_web_group                => 'apache',
    gr_disable_webapp_cache     => true,
    gr_storage_schemas          => [
      {
        name       => 'carbon',
        pattern    => '^carbon\.',
        retentions => '1m:90d'
      },
      {
        name       => 'default',
        pattern    => '.*',
        retentions => '60s:90d,5m:1y,15m:3y'
      },
    ],
    gr_line_receiver_port       => 2003,
    # Additional carbon-cache instances are added here
    # for legacy support of old collectd installations
    # that still send their metrics to port 3003
    gr_cache_instances          => {
      'cache:b' => {
        'LINE_RECEIVER_PORT'   => 3003,
        'PICKLE_RECEIVER_PORT' => 3004,
        'CACHE_QUERY_PORT'     => 3072,
      },
      # These cache instances are added to 'back' the aggregator
      # used for future metrics from the JBoss/Wildfly stack.
      'cache:c' => {
        'LINE_RECEIVER_PORT'   => '3103',
        'PICKLE_RECEIVER_PORT' => '3104',
        'CACHE_QUERY_PORT'     => '3172',
      },
    },
    gr_enable_carbon_aggregator => true,
    gr_aggregator_line_port     => 2023,
    gr_aggregator_destinations  => [
      '127.0.0.1:3103',
    ],
    gr_carbonlink_hosts         => [
      '127.0.0.1:7002:a',
      '127.0.0.1:3072:b',
      '127.0.0.1:3172:c',
    ],
    require                     => File['/opt/graphite'],
  }

  class { '::memcached': }

}
