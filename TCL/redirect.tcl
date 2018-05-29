

#

redirect -file tmp {report_constraint -all_violators -max_delay}

exec grep -c VIOLATED  tmp

file delete tmp

#

redirect -var rptstring {report_constraint -all_violators -max_delay}

regexp -all VIOLATED $rptstring 

set TNV [regexp -all VIOLATED $rptstring]

puts "number of TNV is \t $TNV"

#

if {$TNV < 20} {
	report_timing 
} else { 
	compile -incr -map_effort high }

if { [ info exists $TNV ] } {
	
	if {$TNV < 20} {
		report_timing
	} else {
		compile -incr -map_effort high }
}


if { $TNV == 0 } {
	set new_clk_skew [expr $old_clk_skew * 1.1]
	set_clock_uncertainty $new_clk_skew clk
	compile -incr -map_effort high 
} else { 
	report_timing }
	
 
 
# proc

proc get_TNV {} {

	redirect -var rptstring {report_constraint -all_violators -max_delay}

	regexp -all VIOLATED $rptstring 
	}
	
	
proc get_TNV {min_or_max -max_delay} {

	redirect -var rptstring {report_constraint -all_violators $min_or_max}

	regexp -all VIOLATED $rptstring 
	}

	
set design_files [glob -nocomplaint ./fles/verilog/pp_*.v]
read_verilog $design_files


proc myproc {lib} {
	redirect -var sptstring {report_lib $lib}
	set rptlist [split $rptstring \n]
	puts [lindex $rptlist [lsearh -glob $rptlist "*Time Unit*"]
}





