
set ar(a) 1
set ar(b) 2
set ar(c) 3

puts $ar(b)

foreach i [array names ar] {

puts "$i : $ar($i)"

}


set arr {1 2 3 4 5}
foreach i $arr {

puts $i
}

foreach i [array names ar] {

	puts "$i : $ar($i)"
}


set arr2 {4 5 6 7 8 }

foreach i $arr2 {

	puts $i

}
