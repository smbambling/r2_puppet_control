# == Overview: Manage techtaco.org Website
#
# == Requirements:
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:
class profile::techtaco_org::main (
  Boolean $monitoring = hiera('base::monitoring', true),
  String $ssl_cert    = '/etc/pki/tls/certs/wildcard.techtaco.org-server.crt',
  String $ssl_key     = '/etc/pki/tls/private/wildcard.techtaco.org-server.key',
  String $docroot     = '/vol0/www/techtaco_org/octopress/public',
){

  # Need to make this create /vol0/www/techtaco_org

  apache::vhost { 'techtaco.org-non-ssl' :
    port            => '80',
    docroot         => $docroot,
    servername      => 'techtaco.org',
    #redirect_status => 'permanent',
    #redirect_dest   => 'https://techtaco.org/',
  }

  apache::vhost { 'techtaco.org-ssl':
    servername => 'techtaco.org',
    port       => '443',
    docroot    => $docroot,
    ssl        => true,
    ssl_cert   => $ssl_cert,
    ssl_key    => $ssl_key,
  }

}
