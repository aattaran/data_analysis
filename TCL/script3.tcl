#! /usr/bin/tclsh

proc parser {} {
    puts { 

----------------- Usage -----------------------
 -i(nput)      input  file name
 -o(utput)     output file name
 -p(attern)    the paterrn

 example:
        parser.tcl -i input.txt -o output.txt -p "info|warning|error .... "
    }
}

# checking arguments existance
if { ![llength $argv]} {
    usage
    return
}

# storing command line arguments in dictionary
for {set i 0} {$i < [llength $argv]} { incr i} {
    dict set  args [lindex $argv $i] [lindex $argv [incr i]]
}

# checking arguments  
if { !([dict exists $args "-i"] && [dict exists $args "-o"] && [dict exists $args "-p"] )} {
    usage
    return
}

# reading input file
set inputFile [dict get $args "-i"]
set inFile [open $inputFile "r"]
    set lines [split [read $inFile] "\n"]
close $inFile

# creating output file and fill matched lines into file
set count 0
set outputFile [dict get $args "-o"]
set pattern [dict get $args "-p"]
set outFile [open $outputFile "w"]

    foreach line $lines {
        if { [regexp -nocase $pattern $line]} {
            puts $outFile $line
			incr count
        }
    }
puts $outFile "\nTotal matches of $pattern: $count"
close $outFile
