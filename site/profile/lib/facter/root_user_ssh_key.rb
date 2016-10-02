Facter.add('root_user_ssh_key') do
  confine :kernel => 'Linux'
  pubkey = [
    '/etc/puppetlabs/puppetserver/ssh/id_rsa_code_manager.pub'
  ]
  pubkey.each do |key|
    if File.exists? key
      setcode do
        File.read(key).split
      end
    end
  end
end
