#!/usr/bin/tclsh
#Reading out.txt file line by line and checking *.n file to filter only name part from the code description. 

set path "/pga/synopsys/pts/M-2017.06-SP3-1/doc/pt/man/catn/"
#set path "C:\\ActiveTcl\\bin"

set fp [open "out.txt" r]
while {[gets $fp data] >= 0} {
   if [regexp {\((([A-Z]*)\-[0-9]*)\)} "$data" code match code_name = 1] {
	     
	    #puts $code_name
		#puts $match
	
	    #Opening *.n files
        set fpp [open "$path$code_name/$match\.n" r]
        #set fpp [open "$path\\$code_name\\$match\.n" r]
		set variable_man [read $fpp]
		close $fpp
        if [regexp   {^((.*?))DESCRIPTION} "$variable_man" code_1 match_1 = 1] {
	        if [regexp {NAME\s+((.*?))} $match_1 descrip name_part = 1] {
               # puts $name_part	
		        regsub -all {\s*\n\s*\n(\s*\n)*} $name_part "" name_part
				set fd [open "out_final.txt" a]
                puts $fd "$data    \"$name_part\""
				close $fd
		    }		 
        }
    }
}
close $fp



exec echo "Pattern KeyMessage Count Description" > output_final.txt
exec cat out_final.txt | uniq  >> output_final.txt