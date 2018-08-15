#!/usr/bin/perl

#override current file and create backup
$^I=".bak";

#override given parameters
@ARGV="boot/config.txt";

#diamond opperator: given parameter is a file
while(<>){
    
    #if line matches this regex
    #one number is catched due to parentheses
    if(/disable_camera_led=(\d)/){
        
        #Value of the parentheses is accessed by $1
        $set = $1==1 ? 0 : 1;
        print "disable_camera_led=$set\n";
     
    #we do nothing with all other lines of the file and simply place them back by printing themout
    }else{
       print $_;
    }
}
