# == Overview: Install and Configure Apache Web Server
#
# == Requirements:
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:
# If only this class is called without any additional need
# for vhost, the default_vhost and default_ssl_vhost must
# be set to true to create the needed conf.d site files

class profile::apache (
  #String $pki_keypair = 'wildcard.arin.net-server',
  Boolean $monitoring = hiera("${name}::monitoring", true),
) {

  ## Profile Specific Monitoring ##
  # Note: ${name} variable is used to get the name of the profile class
  #  Ex: ${name} = profile::apache
  if $monitoring {
    profile::sensu::profile::checks {$name:
      profile_name => $name,
    }

    class { 'collectd::plugin::apache':
      instances => {
        'apache80' => {
          'url' => 'http://127.0.0.1/server-status?auto',
        },
      },
    }
  }

  # Make sure PKI Certificates are installed before needed classes
  #Sslmgmt::Ca_dh <| |> -> Sslmgmt::Cert <| |> -> Class['apache']

  class { '::apache':
    default_vhost     => hiera('apache::default_vhost', false),
    default_ssl_vhost => hiera('apache::default_ssl_vhost', false),
    #default_ssl_cert  => hiera('apache::default_ssl_cert', "/etc/pki/tls/certs/${pki_keypair}.crt"),
    #default_ssl_key   => hiera('apache::default_ssl_key', "/etc/pki/tls/private/${pki_keypair}.key"),
    #default_ssl_ca    => hiera('apache::default_ssl_ca', '/etc/pki/tls/certs/arin_internal_ca.crt'),
    trace_enable      => hiera('apache::trace_enable','Off'),
  }

  class { '::apache::mod::ssl':
    ssl_cipher   => hiera('apache::mod::ssl::ssl_cipher', 'HIGH:MEDIUM:!aNULL:!MD5'),
    ssl_protocol => hiera_array('apache::mod::ssl::ssl_protocol', [ 'all', '-SSLv2', '-SSLv3', ]),
  }

  class { '::apache::mod::status':
    allow_from      => hiera_array('apache::mod::status::allow_from', [ '127.0.0.1', '::1', ]),
    extended_status => hiera('apache::mod::status::extended_status', 'On'),
    status_path     => hiera('apache::mod::status::status_path', '/server-status'),
  }

  class { '::apache::mod::info':
    allow_from      => hiera_array('apache::mod::info::allow_from', [ '127.0.0.1', '::1', ]),
    restrict_access => hiera('apache::mod::info::extended_status', true),
  }

  # Configure Logrotate for Apache
  logrotate::rule { 'httpd':
    ensure        => present,
    path          => '/var/log/httpd/*log',
    rotate        => '50',
    rotate_every  => 'day',
    dateext       => true,
    compress      => true,
    ifempty       => false,
    sharedscripts => true,
    missingok     => true,
    postrotate    => [
      '/sbin/service httpd reload > /dev/null 2>/dev/null || true',
      '/bin/chown root:syncer /var/log/httpd',
      '/bin/chmod 2775 /var/log/httpd',
    ],
  }

  # Configure Logwatch to exclude http
  # Need to look at using a merge with the service parameter and hiera
  # This class should be moved into a base class
  class { '::logwatch':
    format  => 'text',
    output  => 'unformatted',
    service => [
      '"-http"',
    ],
  }
 
}
