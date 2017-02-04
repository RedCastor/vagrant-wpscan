class bootstrap {

  # silence puppet and vagrant annoyance about the puppet group
  group { 'puppet':
    ensure => 'present'
  }

  # ensure local apt add repo
  exec { 'apt-add-repository':
    command => '/usr/bin/apt-add-repository ppa:brightbox/ruby-ng'
  }

  # ensure local apt cache index is up to date before beginning
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  # package install list
  $packages = [
    "git",
    "libcurl4-openssl-dev", 
    "libxml2", 
    "libxml2-dev", 
    "libxslt1-dev", 
    "ruby-dev", 
    "build-essential", 
    "libgmp-dev", 
    "zlib1g-dev",
    "ruby2.3", 
    "ruby2.3-dev"
  ]

  # install packages
  package { $packages:
    ensure => present,
    require => Exec[
      "apt-add-repository",
      "apt-get update"
    ]
  }

}
