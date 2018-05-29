set f [open file.txt w+]

puts $f "helloe"
puts $f "helloe"
puts $f "helloe"

close $f

#__________________________________________

set f1 [open file.txt r]

while { ![eof $f1]} {

gets $f1 line
puts $line

}



close $f1