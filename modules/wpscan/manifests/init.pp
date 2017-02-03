class wpscan {
  
  #clone rvm
  exec { 'get-rvm':
    require => Class['bootstrap'],
    cwd => '/vagrant/',
    command => 'curl -sSL https://rvm.io/mpapis.asc | gpg --import - && curl -sSL https://get.rvm.io | bash -s stable'
  }
  
  exec { 'rvm-ruby-source':
    require => Class['bootstrap'],
    cwd => '/vagrant/',
    command => 'source /vagrant/.rvm/scripts/rvm && echo "source /vagrant/.rvm/scripts/rvm" >> ~/.bashrc'
  }
  
  exec { 'rvm-ruby-install':
    require => Class['bootstrap'],
    cwd => '/vagrant/',
    command => 'sudo rvm install 2.3.3 && sudo rvm use 2.3.3 --default'
  }
  
  exec { 'gem-install':
    require => Class['bootstrap'],
    cwd => '/vagrant/',
    command => 'echo "gem: --no-ri --no-rdoc" > /vagrant/.gemrc && sudo gem install bundler'
  }
  
  #clone wpscan
  exec { 'clone-wpscan':
    require => Class['bootstrap'],
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
