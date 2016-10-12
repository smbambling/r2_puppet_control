#== Overview: Installs and manages Grafana
#
# == Requirements:
#  - grafana module
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:

class profile::grafana (
  Boolean $monitoring   = hiera("${name}::monitoring", true),
  String $site_name     = hiera("${name}::site_name"),
  String $ssl_cert      = hiera("${name}::ssl_cert"),
  String $ssl_key       = hiera("${name}::ssl_key"),
  String $version       = hiera("${name}::version"),
  String $rpm_iteration = hiera("${name}::rpm_iteration"),
) {

  ## Profile Specific Monitoring ##
  # Note: ${name} variable is used to get the name of the profile class
  #  Ex: ${name} = profile::pe::mom
  if $monitoring {
    profile::sensu::profile::checks { $name:
      profile_name => $name,
    }
  }

  class { '::grafana':
    version             => $version,
    rpm_iteration       => $rpm_iteration,
    install_method      => 'repo',
    manage_package_repo => true,
    cfg                 => {
      app_mode => 'production',
      server   => {
        http_port => 8080,
      },
      database => {
        'type' => 'sqlite3',
      },
      users    => {
        allow_sign_up => true,
      },
    },
  }

  apache::vhost { "${site_name}-non-ssl" :
    port            => '80',
    docroot         => '/var/www/html',
    servername      => $site_name,
    redirect_status => 'permanent',
    redirect_dest   => "https://${site_name}/",
  }

  apache::vhost { "${site_name}-ssl" :
    servername => $site_name,
    port       => '443',
    docroot    => '/var/www/html',
    ssl        => true,
    ssl_cert   => $ssl_cert,
    ssl_key    => $ssl_key,
    proxy_pass => [
      {
        'path' => '/',
        'url'  => 'http://127.0.0.1:8080',
      },
    ],
    rewrites   => [
      {
        rewrite_cond => ['%{DOCUMENT_ROOT}/%{REQUEST_FILENAME} !-f'],
        rewrite_rule => ['.* http://127.0.0.1:8080%{REQUEST_URI} [P,QSA]'],
      },
    ],
  }
}
