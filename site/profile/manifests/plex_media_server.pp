# == Overview: Install Plex Media Server
#
# == Requirements:
#
# == Monitoring: No monitoring is currently provided
#
# == Notes:

class profile::plex_media_server (
  Boolean $monitoring = hiera('profile::plex_media_server::monitoring', true),
  String $url         =
    'https://downloads.plex.tv/plex-media-server/1.2.3.2914-1ff0f18',
  String $pkg         =
    'plexmediaserver-1.2.3.2914-1ff0f18.x86_64.rpm',

){

  ## Profile Specific Monitoring ##
  # Note: ${name} variable is used to get the name of the profile class
  if $monitoring {
    profile::sensu::profile::checks { $name:
      profile_name => $name,
    }
  }

  class { 'plexmediaserver':
    plex_url => $url,
    plex_pkg => $pkg,
  }

}

