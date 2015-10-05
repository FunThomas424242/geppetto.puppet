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
include archive::prerequisites


class geppetto (
  $user            = 'huluvu424242',
  $geppettoVersion = '4.2.0-R201407250959',
  $tmpDir          = '/tmp',
  $srcURL          = undef,
  $homeDir         = undef,
  $libName         = undef,
  $targetDir       = undef,
  $checksum        = false,) {
 
 include geppetto::params

  notice("srcURL: $geppetto::params::srcURL")
  notice("homeDir: $geppetto::params::homeDir")
  notice("libName: $geppetto::params::libName")
  notice("targetDir: $geppetto::params::targetDir")

  file { $geppetto::params::targetDir:
    ensure => directory,
  }

  file { $geppetto::params::tmpDir:
    ensure  => directory,
  }

  archive { $geppetto::params::libName:
    ensure     => present,
    url        => $geppetto::params::srcURL,
    extension => "zip",
    src_target => $geppetto::params::tmpDir,
    target     => $geppetto::params::targetDir,
    checksum   => $geppetto::params::checksum,
    require    => [File[$geppetto::params::tmpDir], File[$geppetto::params::targetDir]],
  }

  file { 'geppetto.desktop':
    ensure  => file,
    path    => "$geppetto::params::homeDir/Schreibtisch/geppetto.desktop",
    content => template('geppetto/geppetto.desktop.erb'),
    require => Archive[$geppetto::params::libName],
  }
}