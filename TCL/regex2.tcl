proc filtering {file_} { 

	# read log file
	set fh [open $file_ r]
	# set patterns
	set pattern1 "waring"
	set pattern2 "error"
	set pattern3 "info"
	
	set waring_count 0
	
	while { ! [eof $fh] }  {				
		
		gets $fh line
		
		if {[ regexp -nocase -all $pattern1 $line ]} {
		
			#incr $waring_count
			set waring_count [expr {$waring_count + 1 }]
			puts $line
			
		}
		
	}
	puts "number of warnings are: \t $waring_count"
}

filtering dc_shell_01.log
	# write to log file











