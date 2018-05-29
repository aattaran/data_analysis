# find WNS to any output port constrainted by clk1

# create collection of ports

# pass it to report_timing


report_timing -to [all_outputs -clock clk1]


# find info on a pin

report_net -verbose -connections [get_nets -of_objects scan_in_or_4/Y]