#count total number of violations

# report_constraint -all_violators -max_delay

#redirect -var rptstring [report_constraint -all_violators -max_delay]

# regexp -all VIOLATED $rptstring

# set TNV [regexp -all VIOLATED $rptstring]
 
#_______________________________
set TNV 21

# open a file

set file_handler [open tnv.txt w]

# write to file

puts $file_handler "hello"
puts $file_handler "total number of violations is: $TNV"

# close 

close $file_handler

#_______________________________
#read

set file_handler2 [open tnv.txt r]


#gets $file_handler2 each_line
#puts $each_line
# $file_handler2 != "" 
# while { [ gets $file_handler2 each_line] != -1]}
while { ![ eof $file_handler2] } {				

	gets $file_handler2 each_line
	puts $each_line

}

close $file_handler2














