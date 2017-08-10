# == Overview: Manage techtaco.org Website
#
# == Requirements:
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:
class profile::techtaco_org::pogo (
  Boolean $monitoring = hiera('base::monitoring', true),
  String $ssl_cert    = '/etc/pki/tls/certs/wildcard.techtaco.org-server.crt',
  String $ssl_key     = '/etc/pki/tls/private/wildcard.techtaco.org-server.key',
  String $docroot     = '/vol0/www/techtaco_org/pogo',
  String $site_name   = 'pogo.techtaco.org',
){

  # Need to make this create /vol0/www/techtaco_org

  apache::vhost { "${site_name}-non-ssl" :
    port            => '80',
    docroot         => $docroot,
    servername      => $site_name,
    #redirect_status => 'permanent',
    #redirect_dest   => 'https://techtaco.org/',
  }

  apache::vhost { "${site_name}-ssl":
    servername => $site_name,
    port       => '443',
    docroot    => $docroot,
    ssl        => true,
    ssl_cert   => $ssl_cert,
    ssl_key    => $ssl_key,
  }

}
