# == Overview: Manage projectidentitycrisis.com Website
#
# == Requirements:
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:
class profile::projectidentitycrisis_com::main (
  Boolean $monitoring = hiera('base::monitoring', true),
  String $ssl_cert    = '/etc/pki/tls/certs/wildcard.projectidentitycrisis.com-server.crt',
  String $ssl_key     = '/etc/pki/tls/private/wildcard.projectidentitycrisis.com-server.key',
  String $docroot     = '/mnt/raid/www/projectidentitycrisis',
  String $site_name   = 'projectidentitycrisis.com',
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
		#redirect_dest   => 'https://projectidentitycrisis.com/',
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
