# open file , write to file , close
set fl [open ./file.txt w]

puts $fl "hello"

close $fl

# 
#_______________________


redirect -var rptstring {report_constraint -all_violators -max_delay}

set TNV [regexp -all VIOLATED $rptstring ]


set fl [open ./file.txt w]

puts $fl "total number of violations are: "

puts $fl $TNV

close $fl

#_______________________

# open file , read to file , close

set fl [open ./file.txt r]

while { ! [eof $f1] } {

	gets $fl each_line
	puts $each_line

	}
close $fl


#_______________ proc 

proc clk_period {freq} {

	expr 1.0 / $freq
	}
# help -verbose clk_period

define_proc_attributes clk_period \
	-info "calculating period" 
	-command_group My_procs
	-define_args {
		{freq "clok freq" frequency }
	}
	
# array

ser clk(pci_clk) 100
ser clk(sys_clk) 200
ser clk(dft_clk) 300

puts "period of pci clock is $clk(pci_clk)



