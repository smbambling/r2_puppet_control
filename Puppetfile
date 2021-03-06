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

mod 'firewall',
  :git => 'https://github.com/puppetlabs/puppetlabs-firewall.git',
  :ref => '1a25c00' # tag: 1.8.1

mod 'sslmgmt',
  :git => 'https://github.com/tykeal/puppet-sslmgmt.git',
  :ref => 'ad28efd' # tag: v1.0.1

mod 'ca_cert',
  :git => 'https://github.com/pcfens/puppet-ca_cert.git',
  :ref => '2589535' # tag v1.2.0

mod 'sudo',
  :git => 'https://github.com/saz/puppet-sudo.git',
  :ref => 'e5fe01b' # tag: v3.1.0

mod 'accounts',
  :git => 'https://github.com/smbambling/puppetlabs-accounts.git',
  :ref => '4e1570c'

mod 'plexmediaserver',
  :git => 'https://github.com/smbambling/plex-media-server.git',
  :ref => '1fb8cb0'

mod 'archive',
  :git => 'https://github.com/voxpupuli/puppet-archive.git',
  :ref => '7798ebb' # tag: v0.5.1

mod 'yumrepo',
  :git => 'https://github.com/smbambling/bambling-yumrepo.git',
  :ref => '58fbcdc'

mod 'apache',
  :git => 'https://github.com/puppetlabs/puppetlabs-apache.git',
  :ref => 'd76699a' # tag: 1.8.1

mod 'concat',
  :git => 'https://github.com/puppetlabs/puppetlabs-concat.git',
  :ref => '8d479b3' # tag: 2.1.0

mod 'logrotate',
  :git => 'https://github.com/yo61/puppet-logrotate.git',
  :ref => '499b74b' # tag: v1.3.0

mod 'logwatch',
  :git => 'https://github.com/jonmosco/puppet-logwatch.git',
  :ref => 'a66f4f9' # tag: 0.1.1

mod 'vcsrepo',
  :git => 'https://github.com/puppetlabs/puppetlabs-vcsrepo.git',
  :ref => 'f98e8f0' # tag: 1.3.2

mod 'inifile',
  :git => 'https://github.com/puppetlabs/puppetlabs-inifile.git',
  :ref => '3863d9a' # tag: 1.4.3

mod 'selinux',
  :git => 'https://github.com/voxpupuli/puppet-selinux.git',
  :ref => 'v0.5.0' # tag: v0.5.0

mod 'dirtree',
  :git => 'https://github.com/puppetlabs/pltraining-dirtree.git',
  :ref => 'b738612' # forge release: v0.2.2

mod 'ohmyzsh',
   :git => 'https://github.com/bitswarmlabs/puppet-ohmyzsh.git',
   :ref => '6644f0e' # tag: 2.0.2

mod 'graphite',
  :git => 'https://github.com/echocat/puppet-graphite.git',
  :ref => 'cfe143d' # tag: v7.3.0

mod 'memcached',
  :git => 'https://github.com/saz/puppet-memcached',
  :ref => 'bfa64e0' # branch: master

mod 'grafana',
  :git => 'https://github.com/voxpupuli/puppet-grafana.git',
  :ref => '5f4a7cf' # v4.2.0

mod 'collectd',
  :git => 'https://github.com/voxpupuli/puppet-collectd.git',
  :ref => 'f5a44db' # tag: v5.1.0
