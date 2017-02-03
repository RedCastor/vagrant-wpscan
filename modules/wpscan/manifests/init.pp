class wpscan {
  
  #clone rvm
  exec { 'get-rvm':
    require => Class['bootstrap'],
    cwd => '/home/vagrant/',
    command => 'curl -sSL https://rvm.io/mpapis.asc | gpg --import - && curl -sSL https://get.rvm.io | bash -s stable'
  }
  
  exec { 'rvm-ruby-source':
    require => Exec['get-rvm'],
    cwd => '/home/vagrant/',
    command => 'sudo source /home/vagrant/.rvm/scripts/rvm && echo "sudo source /home/vagrant/.rvm/scripts/rvm" >> /home/vagrant/.bashrc'
  }
  
  exec { 'rvm-ruby-install':
    require => Exec['rvm-ruby-source'],
    cwd => '/home/vagrant/',
    command => 'sudo rvm install 2.3.3 && sudo rvm use 2.3.3 --default'
  }
  
  exec { 'gem-install':
    require => Exec['rvm-ruby-install'],
    cwd => '/home/vagrant/',
    command => 'echo "gem: --no-ri --no-rdoc" > /home/vagrant/.gemrc && sudo gem install bundler'
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
