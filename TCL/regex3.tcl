
set fh [open file1.txt r]

set pattern1 {hello*}

			

	if {[ regexp $pattern1 $fh  ]} {
	
		gets $fh line 
		puts $line
	}














