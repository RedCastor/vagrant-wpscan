class bootstrap {

  # silence puppet and vagrant annoyance about the puppet group
  group { 'puppet':
    ensure => 'present'
  }

  # ensure local apt cache index is up to date before beginning
  exec { 'apt-get update':
    command => '/usr/bin/apt-add-repository ppa:brightbox/ruby-ng && /usr/bin/apt-get update'
  }

  # package install list
  $packages = [
    "git",
    "libcurl4-gnutls-dev",
    "libxml2",
    "libxml2-dev",
    "libxslt1-dev",
    "ruby2.3", 
    "ruby2.3-dev"
    "build-essential"
  ]

  # install packages
  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

}
