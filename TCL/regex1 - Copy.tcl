proc filtering {file_} { 

	# read log file
	set fh [open file1.txt r]
	# set patterns
	set pattern1 "waring"

	while { ! [eof $fh] }  {				

		gets $fh line
		
		if {[ regexp -nocase -all $pattern1 $line ]} {
		
			puts $line
		}
	}
}

filtering file1.txt
	# write to log file











