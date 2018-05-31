#!/usr/bin/tclsh

proc parser {input_file output_file pattern} {
    proc read_file {fname} {
        set fd [open $fname r]
        set data [read $fd]
        close $fd
        return $data
    }

    set input_data [read_file $input_file]
    set output_data [regexp -all -inline -line -nocase -- "${pattern}:.*" $input_data]

    if {$output_data eq ""} {
        puts stderr "nothing was found in $input_file using \"$pattern\" pattern"
        exit 1
    }

    set count 0
    set out [open $output_file w]
    foreach match $output_data {
        puts $out $match
        incr count
    }
    puts $out "\nTotal matches: $count"
    close $out
}

if {[info exists argv0]
        && [file dirname [file normalize [info script]/...]]
        eq [file dirname [file normalize $argv0/...]]} {
    if {$argc != 3} {
        puts stderr "usage: [file tail $argv0] <input.log> <output.log> <pattern>"
        exit 1
    }
    parser [lindex $argv 0] [lindex $argv 1] [lindex $argv 2]
} else {
    package provide parser 1.0
}

