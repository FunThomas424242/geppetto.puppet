# Class: geppetto::params
#
# This class defines some parameters
#
class geppetto::params (
  $user = $::id,
  $geppettoVersion = '4.2.0-R201407250959',
  $tmpDir = '/tmp',
  $homeDir = "/home/${::id}",
  $targetDir = "/home/${::id}/installationen",
  $checksum = false,
)
{
  
  $srcURL = undef ?{
    default => "https://downloads.puppetlabs.com/geppetto/4.x/geppetto-linux.gtk.x86_64-${geppettoVersion}.zip"
  }
  
  
  $libName = undef ? {
    default => "geppetto-${geppettoVersion}"
  }

}