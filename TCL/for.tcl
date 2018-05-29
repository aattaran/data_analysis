set a 1
while {$a <10} {
puts $a
incr a
}


for {set i 0} {$i <10} { incr i} {
puts $i 
}

set a {1 2 3 4}
puts $a

foreach t $a {

puts $t
}