#

#_______________procs

proc clean_log {args} {
	parse_proc_arguments -args $args results
	}
 
 define_proc_attributes play -info "For exploration" \
	-define_args {
		{-verbose "generate verbose output" "" boolean optional}
		{-friut "any fruit" Fruit string required}
		{-veggie "any veggie" Vegetable string optional}
	}
	
	
 
  # string
  
 # string match {sd_DQ \ [ [2-6] \] } $myport