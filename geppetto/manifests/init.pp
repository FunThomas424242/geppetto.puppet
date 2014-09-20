# Class: geppetto
#
# This module manages geppetto
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class geppetto (
  $user            = 'huluvu424242',
  $geppettoVersion = '4.2.0-R201407250959',
  $tmpDir          = '/tmp',
  $srcURL          = undef,
  $homeDir         = undef,
  $libName         = undef,
  $targetDir       = undef,
  $checksum        = false,) {
  # init srcURL
  if $srcURL == undef {
    $_srcURL = "https://downloads.puppetlabs.com/geppetto/4.x/geppetto-linux.gtk.x86_64-$geppettoVersion.zip"
  } else {
    $_srcURL = $srcURL
  }

  # init homeDir
  if $homeDir == undef {
    $_homeDir = "/home/$user"
  } else {
    $_homeDir = $homeDir
  }

  # init libName
  if $libName == undef {
    $_libName = "geppetto-$geppettoVersion"
  } else {
    $_libName = $libName
  }

  # init targetDir
  if $targetDir == undef {
    $_targetDir = "$_homeDir/installationen"
  } else {
    $_targetDir = $targetDir
  }

  notice("_srcURL: $_srcURL")
  notice("_homeDir: $_homeDir")
  notice("_libName: $_libName")
  notice("_targetDir: $_targetDir")

  file { $_targetDir:
    ensure => directory,
  }

  file { $tmpDir:
    ensure  => directory,
  }

  archive { $_libName:
    ensure     => present,
    url        => $_srcURL,
    src_target => $tmpDir,
    target     => $_targetDir,
    checksum   => $checksum,
    require    => [File[$tmpDir],File[$_targetDir]],
  }

  file { 'geppetto.desktop':
    ensure  => file,
    path    => "$_homeDir/Schreibtisch/geppetto.desktop",
    content => template('gepetto/gepetto.desktop.erb'),
    require => Archive[$_libName],
  }
}