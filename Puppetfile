#!/usr/bin/env ruby
#^syntax detection

# Puppet Forge URL
# This can be an internal forge also if required (https://github.com/drrb/puppet-library)
forge "https://forgeapi.puppetlabs.com"

# use dependencies defined in metadata.json
#metadata

# use dependencies defined in Modulefile
# modulefile

# Set the 'environment' from the Puppetfile basedir using the r10k
# libraian class.
# https://github.com/puppetlabs/r10k/blob/master/lib/r10k/puppetfile.rb

mod 'stdlib',
  :git => 'https://github.com/puppetlabs/puppetlabs-stdlib.git',
  :ref => '5727506' # tag: 4.8.0

mod 'ca_cert',
  :git => 'https://github.com/pcfens/puppet-ca_cert.git',
  :ref => '2589535' # tag v1.2.0

mod 'sudo',
  :git => 'https://github.com/saz/puppet-sudo.git',
  :ref => 'e5fe01b' # tag: v3.1.0

mod 'accounts',
  :git => 'https://github.com/smbambling/puppetlabs-accounts.git',
  :ref => '4e1570c'

mod 'plex',
  :git => 'https://github.com/smbambling/plex-media-server.git',
  :ref => '1fb8cb0'
