#!/usr/bin/perl
$^I = ".bak";

my $url     = 'http://www.sunrise-and-sunset.com/nl/sun/belgie/ninove';
my $logfile = '/var/log/sunsetManager.log';
@ARGV = '/boot/config.txt'

  my $html = qx{wget --quiet --output-document=- $url};
$html =~ s/\s//g;    #remove all whitespace

#array (hour, min)
@zonsopgang    = $html =~ /<th>Zonsopgangvandaag<\/th><td>(\d\d):(\d\d)/;
@zonsondergang = $html =~ /<th>Zonsondergangvandaag<\/th><td>(\d\d):(\d\d)/;

#remove leading zero's
foreach (@zonsopgang)    { $_ =~ s/^0//; }
foreach (@zonsondergang) { $_ =~ s/^0//; }

if ( timeMatch(@zonsondergang) || timeMatch(@zonsondergang) ) {
    while (<>) {

        #if line matches this regex
        #one number is catched due to parentheses
        if (/disable_camera_led=(\d)/) {

            #Value of the parentheses is accessed by $1
            $set = $1 == 1 ? 0 : 1;
            print "disable_camera_led=$set\n";
            logManager("disable_camera_led=$set");

#we do nothing with all other lines of the file and simply place them back by printing themout
        }
        else {
            print $_;
        }
    }
}

#usage: timeMatch($hour,$minutes)
sub timeMatch {
    my ( $parahour, $paramin ) = @_;
    my ( $sec, $currentmin, $currenthour ) = localtime(time);
    $decimalvalueofparamin    = substr( $paramin,    0, 1 );
    $decimalvalueofCurrentmin = substr( $currentmin, 0, 1 );

    # 3:33 matches 3:39, therefor, the program should run every 10 minutes.
    if (   $parahour == $currenthour
        && $decimalvalueofCurrentmin == $decimalvalueofparamin )
    {
        return true;
    }
    else {
        return false;
    }
}

#usage: timeMatch($hour,$minutes)
sub logManager {
    open( my $fh, '>>', $logfile ) or die "Could not open file '$logfile' $!";
    my ($content) = @_;
    my ( $sec, $m, $H ) = localtime(time);
    print $fh $m . ":" . $H . " | " . $content . "\n";
    close $fh;
}
