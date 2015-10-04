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
 

  notice("srcURL: $geppetto::params::srcURL")
  notice("homeDir: $geppetto::params::homeDir")
  notice("libName: $geppetto::params::libName")
  notice("targetDir: $geppetto::params::targetDir")

  file { $targetDir:
    ensure => directory,
  }

  file { $tmpDir:
    ensure  => directory,
  }

  archive { $libName:
    ensure     => present,
    url        => $srcURL,
    extension => "zip",
    src_target => $tmpDir,
    target     => $targetDir,
    checksum   => $checksum,
    require    => [File[$tmpDir], File[$targetDir]],
  }

  file { 'geppetto.desktop':
    ensure  => file,
    path    => "$homeDir/Schreibtisch/geppetto.desktop",
    content => template('geppetto/geppetto.desktop.erb'),
    require => Archive[$libName],
  }
}