
puts "which protocl to use? tcp/udp"
set in [gets stdin]

if { $in != "tcp" && $in != "udp" } {
puts "no"
}

while { $in != "tcp" && $in != "udp" } {
puts "no"
puts "which protocl to use? tcp/udp"
set in [gets stdin]

}

puts "this is chosen : $in"

