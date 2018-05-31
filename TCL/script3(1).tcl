#! /usr/bin/tclsh

proc usage {} {
    puts { 

----------------- Usage -----------------------
 -i(nput)      input  file name
 -o(utput)     output file name
 -p(attern)    the paterrn

 example:
        parser.tcl -i input.txt -o output.txt -p "info|warning|error .... "
    }
}

# Pattern Inputs
# Currently, there is only one pattern in the list,
# but it needs be list of patterns
# in case there are multiple ways message types are reported.
set tool_config {
    dc_shell    {
        messages {
            info            {{^\s*Information:.*?\([A-Z]{3,4}-[0-9]{3}\)\s*$}}
            warning         {{^\s*Warning:.*?\([A-Z]{3,4}-[0-9]{3}\)\s*$}}
            error           {{^\s*Error:.*?\([A-Z]{3,4}-[0-9]{3}\)\s*$}}
        }
    }
}

set tool dc_shell       ; # To be set at the command prompt.  Probably should have a default value.  Not sure what.

set config      [dict get $tool_config $tool]
set messages    [dict get $config messages]

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
set outputFile [dict get $args "-o"]
set pattern [dict get $args "-p"]
set outFile [open $outputFile "w"]

unset -nocomplain count
foreach message_type [dict keys $messages] {
    set count($message_type) 0
}

foreach line $lines {
    dict for {message_type message_pattern_list} $messages {
        foreach message_pattern $message_pattern_list {
            if [regexp -- $pattern $line] {
                puts $outFile $line
                incr count($message_type)
            }
        }
    }
}

puts $outFile "\nTotal matches of $pattern: [array get count]"
close $outFile
