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
