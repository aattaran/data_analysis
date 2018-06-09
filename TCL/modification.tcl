#!/usr/bin/tclsh
#Reading out.txt file line by line and running "man code" to 
#store description of the code in <code.n> file and filtering only name part from the code description. 



set fp [open "out.txt" r]
while {[gets $fp data] >= 0} {
   if [regexp {\(([A-Z]*\-[0-9]*)\)} "$data" code match = 1] {
	    # puts $match
		#Path can be modified as per the requirement 
        #If you have to create a dirrectory with the code name it can be done 
		#with exec mkdir <$match> where match is the variable which holds code name
	    
		exec man $match > $match.n
	
	    #Filtering only NAME part from man code command output

        set variable_man [exec man $match]
		
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