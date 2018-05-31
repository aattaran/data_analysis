
set fh [open file1.txt r]

set pattern1 "waring"

while { ! [eof $fh] }  {				

	gets $fh line
	
	if {[ regexp -nocase -all $pattern1 $line ]} {
	
		puts $line
	}
}













