# Class: geppetto::params
#
# This class defines some parameters
#
class geppetto::params {

  $user = undef ? {
    default => $::id
  }
 
  $geppettoVersion = undef ? {
    default => '4.2.0-R201407250959'
  }
  
  $tmpDir = undef ? {
    default => '/tmp'
  }
  
  
  $srcURL = undef ?{
    default => "https://downloads.puppetlabs.com/geppetto/4.x/geppetto-linux.gtk.x86_64-$geppettoVersion.zip"
  }       
  
  $homeDir = undef ? {
    default => "/home/$user"
  }
  
  $libName = undef ? {
    default => "geppetto-$geppettoVersion"
  }   
  
  $targetDir = undef ?{
    default => "$homeDir/installationen"
  }
  
  $checksum = undef ? {
    default => false
  }   
 
}