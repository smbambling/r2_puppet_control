# == Overview: Manage bambling.org Website
#
# == Requirements:
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:
class profile::bambling_org (
  Boolean $monitoring = hiera('base::monitoring', true),
  String $ssl_cert    = '/etc/pki/tls/certs/wildcard.bambling.org-server.crt',
  String $ssl_key     = '/etc/pki/tls/private/wildcard.bambling.org-server.key',
){

  apache::vhost { 'bambling.org-non-ssl' :
    port            => '80',
    docroot         => '/var/www/html',
    servername      => 'bambling.org',
    redirect_status => 'permanent',
    redirect_dest   => 'https://bambling.org/',
  }

  apache::vhost { 'bambling.org-ssl':
    servername => 'bambling.org',
    port       => '443',
    docroot    => '/var/www/html',
    ssl        => true,
    ssl_cert   => $ssl_cert,
    ssl_key    => $ssl_key,
  }

}


