# Class: geppetto
#
# This module manages geppetto
#
# Parameters: none
#
# Actions:
#
# Requires: see metadata.json
#
# Sample Usage:
#



class geppetto () {

  include archive::prerequisites

  include geppetto::params

  $libName         = $geppetto::params::libName
  $targetDir       = $geppetto::params::targetDir


  notice("srcURL: ${geppetto::params::srcURL}")
  notice("homeDir: ${geppetto::params::homeDir}")
  notice("libName: ${geppetto::params::libName}")
  notice("targetDir: ${geppetto::params::targetDir}")

  file { $geppetto::params::targetDir:
    ensure => directory,
  }

  file { $geppetto::params::tmpDir:
    ensure  => directory,
  }

  archive { $geppetto::params::libName:
    ensure     => present,
    url        => $geppetto::params::srcURL,
    extension  => 'zip',
    src_target => $geppetto::params::tmpDir,
    target     => $geppetto::params::targetDir,
    checksum   => $geppetto::params::checksum,
    require    => [File[$geppetto::params::tmpDir]
      , File[$geppetto::params::targetDir]
    ],
  }

  file { 'geppetto.desktop.Schreibtisch':
    ensure  => file,
    path    => "${geppetto::params::homeDir}/Schreibtisch/geppetto.desktop",
    content => template('geppetto/geppetto.desktop.erb'),
    require => Archive[$geppetto::params::libName],
  }
  
  file { 'geppetto.desktop.local':
    ensure  => file,
    path    => "${geppetto::params::homeDir}
    /.local/share/applications/geppetto.desktop",
    content => template('geppetto/geppetto.desktop.erb'),
    require => Archive[$geppetto::params::libName],
  }
}