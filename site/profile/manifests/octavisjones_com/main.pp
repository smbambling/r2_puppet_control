# == Overview: Manage octavisjones.com Website
#
# == Requirements:
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:
class profile::octavisjones_com::main (
  Boolean $monitoring = hiera('base::monitoring', true),
  String $ssl_cert    = '/etc/pki/tls/certs/wildcard.octavisjones.com-server.crt',
  String $ssl_key     = '/etc/pki/tls/private/wildcard.octavisjones.com-server.key',
  String $docroot     = '/mnt/raid/www/octavisjones',
  String $site_name   = 'octavisjones.com',
){

  # Need to make this create /mnt/raid/www

  dirtree { $docroot:
    ensure  => present,
    path    => $docroot,
    parents => true,
  }

  apache::vhost { "${site_name}-non-ssl" :
    port            => '80',
    docroot         => $docroot,
    servername      => $site_name,
    require         => Dirtree["$docroot"],
		#redirect_status => 'permanent',
		#redirect_dest   => 'https://octavisjones.com/',
  }

  apache::vhost { "${site_name}-ssl":
    servername => $site_name,
    port       => '443',
    docroot    => $docroot,
    ssl        => true,
    ssl_cert   => $ssl_cert,
    ssl_key    => $ssl_key,
    require    => Dirtree["$docroot"],
  }

}
