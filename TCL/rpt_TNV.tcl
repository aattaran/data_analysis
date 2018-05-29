
proc rpt_TNV {} { 

redirect -variable rptstring {report_constraint -all_violators -nosplit}

# Calculate TNV for each clock group

foreach line [split $rptstring \n] {
    if {[string match *VIOLATED* $line]} {
             incr TNV
        } else {
             echo $line
             set TNV 0
       }
   }
}; # End proc





  










