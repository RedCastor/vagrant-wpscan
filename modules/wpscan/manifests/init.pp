class wpscan {

  #Add Repo
  exec { 'add-repo':
    require => Class['bootstrap'],
    cwd => '/vagrant/',
    command => 'sudo apt-add-repository ppa:brightbox/ruby-ng && sudo apt-get -y update'
  }
  
  #Install Ruby 2.3
  exec { 'ruby-2-3':
    require => Exec['add-repo'],
    cwd => '/vagrant/',
    command => 'sudo apt-get -y install ruby2.3 ruby2.3-dev'
  }
  
  #clone wpscan
  exec { 'clone-wpscan':
    require => Exec['ruby-2-3'],
    cwd => '/vagrant/',
    command => 'git clone https://github.com/wpscanteam/wpscan.git'
  }

  #install bundler
  exec { 'install-bundler':
    require => Exec['clone-wpscan'],
    cwd => '/vagrant/wpscan/',
    command => 'sudo gem install bundler && bundle install --without test'
  }
}
