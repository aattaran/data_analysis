#! /usr/bin/tclsh


## Defineing proc usage for users
proc usage {} {
    puts { Wrong argument set.

----------------- options -----------------------
 -i(nput)   :   Input file name to extaraxt matched lines
 -o(utput)  :   Output file name to store matched lines
 -p(attern) :   The paterrn to match lines
 -ig(nore)  :   Ignore already matched lines

 example:
        parser.tcl -i input.txt -o output.txt -p "info|warning|erro* .... " -ig "error"
    }
}

## Breaks the long string into multiple lines
proc format_str {str} {
    set begin 50
    set index [string first { } $str $begin]
    while {$index!=-1} {
        set str [string replace $str $index $index "\n\t\t\t\t"]
        incr begin 100
        set index [string first { } $str $begin]
    }

    return $str
}

## checking arguments existance
if { ![llength $argv]} {
    usage
    return
}

## storing command line arguments in dictionary
for {set i 0} {$i < [llength $argv]} { incr i} {
    dict set  args [lindex $argv $i] [lindex $argv [incr i]]
}

## checking arguments  
if { !([dict exists $args "-i"] && [dict exists $args "-o"] && [dict exists $args "-p"] )} {
    usage
    return
}
set ignore ""
## checking optional arguments
if { [dict exists $args "-ig"] } {
    set ignore [dict get $args "-ig" ]
}


## reading input file
set inputFile [dict get $args "-i"]
set inFile [open $inputFile "r"]
    set lines [split [read $inFile] "\n"]
close $inFile

## creating output file and fill matched lines into file
set outputFile [dict get $args "-o"]
set pattern [dict get $args "-p"]
# filling matched lines to list
set lineList ""

set fileMessage [open "fileMessage.txt" "w"]
set message ""
foreach line $lines {
    if { [regexp -nocase $pattern $line message] } {
        if { [regexp {\(\w+\-\d+\)$} $line match ] } {
             puts $fileMessage "$message $match"
            if {[info exists codes($match)]} {
                incr codes($match)
            } else {
                set codes($match) 1
            }
        }
        lappend lineList $line
    }
}
close $fileMessage
set unicLineList [lsort -unique $lineList]
set outFile [open $outputFile "w"]

## Info about matched, dublicated and uniq lines.
set unicLines [llength $unicLineList]
set totalMatchedLines [llength $lineList]
set ignoreLinesCount 0
#set messageNumber "([A-Z]+-\d+)$"
puts "\n***** Parsing Summary *****"
puts  "  Total Matched Lines : $totalMatchedLines\n \
            Dublicated Lines    : [expr $totalMatchedLines - $unicLines]\n \
            Uniq Lines          : $unicLines"

foreach line $unicLineList {
    ## looping none duplicated lines to ignore some pattern and write in file
    if { $ignore != "" } {
        ## Check if Argument passeD, ignore passed pattern
        if { [regexp $ignore $line] } {
            ## check in the end of line message number

            incr ignoreLinesCount
            ## check if passed ignore pattern matched, continue foreach to skip line
            continue
        }
    }

    ## write lines to output file
    puts $outFile $line
}
#exec echo "Pattern keyMessage Count" > out.txt
#exec cat fileMessage.txt | sort | uniq -c | awk {{print $2 " " $3 " " $1 }} >> out.txt
puts  "  Ignored lines count : $ignoreLinesCount\n"
close $outFile

set ofile [open "out.txt" w]

foreach code [array names codes] {
    set manname "[string trim $code {()}].n"

    set manpath "/pga/synopsys/pts/M-2017.06-SP3-1/doc/pt/man/catn/$manname"
    if {[string match "PTE*" $manname]} {
        set manpath "/pga/synopsys/pts/M-2017.06-SP3-1/doc/pt/man/catn/PTE/$manname"
    }

    set namestr ""
    if [file exists $manpath] {
        set manf [open $manpath "r"]
        set lines [split [read $manf] "\n"]
        set use 0
        foreach line $lines {
            
            if {[regexp {^NAME} $line]} {
                set use 1
                continue
            }
            
            if {$use && [regexp {^[ \t]*$} $line]} {
                set use 0
                break
            }
            
            if {$use} {
                set ws " "
                if {[string index $namestr end]=="-"} {
                    set namestr [string trim $namestr "-"]
                    set ws ""
                }
                append namestr "$ws[string trim $line]"
            }
        }

        close $manf
    }
    puts $ofile "$message\t$code\t$codes($code)\t[format_str $namestr]"
 #   puts "$message $code $codes($code) $namestr"

}

close $ofile
