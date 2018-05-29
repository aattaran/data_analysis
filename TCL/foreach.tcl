foreach item "A b c d" {

	puts $item }
	
	
set list_of_clks "c1 c2 c3"
lappend list_of_clks c5
puts $list_of_clks
#printvar $list_of_clks 


set coll_clks [get_clocks "c1 c2"]
append_to_collection coll_clks [get clocks c3]