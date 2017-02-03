class wpscan {
  
  #clone rvm
  exec { 'get-rvm':
    require => Class['bootstrap'],
    cwd => '~',
    command => 'curl -sSL https://rvm.io/mpapis.asc | gpg --import - && curl -sSL https://get.rvm.io | bash -s stable'
  }
  
  exec { 'rvm-ruby-source':
    require => Exec['get-rvm'],
    cwd => '~',
    command => 'source /vagrant/.rvm/scripts/rvm && echo "source /vagrant/.rvm/scripts/rvm" >> ~/.bashrc'
  }
  
  exec { 'rvm-ruby-install':
    require => Exec['rvm-ruby-source'],
    cwd => '~',
    command => 'rvm install 2.3.3 && rvm use 2.3.3 --default'
  }
  
  exec { 'gem-install':
    require => Exec['rvm-ruby-install'],
    cwd => '~',
    command => 'echo "gem: --no-ri --no-rdoc" > /vagrant/.gemrc && sudo gem install bundler'
  }
  
  #clone wpscan
  exec { 'clone-wpscan':
    require => Exec['gem-install'],
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
