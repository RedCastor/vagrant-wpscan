class wpscan {

  #clone rvm
  exec { 'get-rvm':
    require => Class['bootstrap'],
    cwd => '/vagrant/',
    command => 'sudo apt-get -y install software-properties-common '
  }
  
  exec { 'rvm-ruby-source':
    require => Exec['get-rvm'],
    cwd => '/vagrant/',
    command => 'sudo apt-add-repository ppa:brightbox/ruby-ng'
  }
  
  exec { 'rvm-ruby-install':
    require => Exec['rvm-ruby-source'],
    cwd => '/vagrant/',
    command => 'sudo apt-get -y install ruby2.3'
  }
  

  #clone wpscan
  exec { 'clone-wpscan':
    require => Exec['rvm-ruby-install'],
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
