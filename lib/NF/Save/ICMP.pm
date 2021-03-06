package NF::Save::ICMP;

use strict;
use warnings;
 
my @aMixinSubs = qw/_icmp/;

sub Init
{
  my ($oSelf) = @_;

  my $paLookup = ['icmp' => 'icmp'];
  my $paPre = [qw/proto owner match list tcp udp/];
  my $paPost = [qw/conntrack limit comment jump/];

  return @aMixinSubs if ($oSelf->_add_module($paLookup, $paPre, $paPost));
}
 
# Return an array of ICMP protocol match strings
sub _icmp
{
  my ($oSelf, $phParams) = @_;

  return [$oSelf->_str_map($phParams, {
      'map' => [
        'name +req lc' => "-p",
        'name +req lc' => "-m",
        'type +not' => '--icmp-type',
      ], 
      'alt' => {
        'name' => "key"
      }, 
    }
  )];
}

 
1;

