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
  String $ssl_cert      = hiera("${name}::ssl_cert", "/etc/ssl/certs/${::fqdn}-server.crt"),
  String $ssl_key       = hiera("${name}::ssl_key", "/etc/pki/tls/private/${::fqdn}-server.key"),
  String $ldap_server   = hiera("${name}::ldap_server", 'corp.arin.net'),
  String $ldap_password = hiera("${name}::ldap_password", ''),
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
      app_mode    => 'production',
      server      => {
        http_port => 8080,
      },
      database    => {
        'type' => 'sqlite3',
      },
      users       => {
        allow_sign_up => false,
      },
      'auth.ldap' => {
        enabled     => true,
        config_file => '/etc/grafana/ldap.toml',
      },
    },
  }


  # We have to use a heredoc here because
  # the way the grafana module does this
  # is by using the toml gem,
  # and there is no way to set group_mappings
  # properly, due to the fact that since a has is
  # unordered, it flips around like a fish out of water.

  $ldap_config = @("LDAPCONFIG"/L)
    [[servers]]
    bind_dn = "CORP\\\srv.graphite"
    bind_password = "$ldap_password"
    host = "$ldap_server"
    port = 636
    search_base_dns = ["OU=Internal,OU=Users,OU=CHA,DC=corp,DC=arin,DC=net"]
    search_filter = "(sAMAccountName=%s)"
    use_ssl = true

    [servers.attributes]
    email = "email"
    member_of = "memberOf"
    name = "givenName"
    surname = "sn"
    username = "sAMAccountName"

    [[servers.group_mappings]]
    group_dn = "CN=OPS,OU=Support,OU=Groups,OU=CHA,DC=corp,DC=arin,DC=net"
    org_role = "Admin"
    | LDAPCONFIG

  file { '/etc/grafana/ldap.toml':
    ensure  => 'file',
    content => $ldap_config,
    owner   => 'root',
    group   => 'grafana',
    mode    => '0640',
    notify  => Service['grafana-server'],
  }

  apache::vhost { "${::fqdn}-non-ssl" :
    port            => '80',
    docroot         => '/var/www/html',
    servername      => $::fqdn,
    redirect_status => 'permanent',
    redirect_dest   => "https://${::fqdn}/",
  }

  apache::vhost { "${::fqdn}-ssl" :
    servername => $::fqdn,
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
