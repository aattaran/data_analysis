proc add { a b } {

set c [expr $a+$b]
return   $c
}

puts [add 3 2]