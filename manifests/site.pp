## Managed by Puppet + R10k

# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run. The Puppet Enterprise console needs this to display file contents
# and differences.

# Make filebucket 'puppet' the default backup location for all File resources:
# This enables the local 'default' 'puppet' filebucket.
# Files will ONLY be entered into the local filebucket and NOT copied up to the
# PuppetServer or MoM
File { backup => 'puppet' }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

# This sets the custom_node_role top scope variable based on a custom created
# fact. The $custom_node_role fact is NOT default and must manually be added or
# injected/overridden with FACTER_custom_node_role='role::somerole'

node default {
  if ! empty($custom_node_role) {
    info("Classifying ${fqdn} with role: ${custom_node_role}")
    include $custom_node_role
  } else {
    err($err_message)
  }
}
