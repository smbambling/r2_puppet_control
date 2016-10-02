require 'puppet'

Facter.add("stats_hostname") do
  setcode do
      `hostname`.rstrip.split('.').reverse.join('.')
  end
end
