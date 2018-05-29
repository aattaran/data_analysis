#count flop per cell

# create collection of cells and flops

set leafcells [get_cells *]
set flops [get_registers]



#count them

set num_cells [sizeof_collection $leafcells]

set num_flops [sizeof_collection $flops]

set percentage [expr $num_flops * 100 / $num_cells]

puts "percentage of flops per  cell is $percentage"