# == Overview: Install,Configure and Register letsencrypt client
#
# == Requirements:
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:

class profile::letsencrypt (
  Boolean $monitoring = hiera('profile::letsencrypt::monitoring', true),
  String $email       = hiera('profile::letsencrypt::email'),
){

  class { '::letsencrypt':
    configure_epel => false,
    email          => $email,
    config         => {
      server => 'https://acme-staging.api.letsencrypt.org/directory',
    },
  }

  letsencrypt::certonly { 'bambling.org': }

}
