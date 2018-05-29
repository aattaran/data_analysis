
proc sum args {

	set s 0
	foreach i $args {
		incr s $i
		}
	return $s
	}
	
puts [sum 1 2 3 4 5 ]