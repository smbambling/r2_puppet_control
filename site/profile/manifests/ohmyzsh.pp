# == Overview: Manage local ohmyzsh user installation
#
# == Requirements:
#
#
# == Notes:

class profile::ohmyzsh(){

  # Manage User Accounts
#  hiera_hash('managed_users')[users].each | String $user, Hash $user_value | {
#    if hiera_hash('accounts::users')[$user]['ohmyzsh'] {
#     ohmyzsh::install { $user: }
#      ohmyzsh::fetch::theme { $user: url =>
#      'http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme' }
#    }
#  }


}

