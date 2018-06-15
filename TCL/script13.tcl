#! /usr/bin/tclsh


## Defineing proc usage for users ##############################################################################
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
###############################################################################################################


## munipulating command line arguments ##########################################################################
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
#########################################################################################################


## checking optional arguments and reading ignore file content ##########################################
    set ignore ""
    if { [dict exists $args "-ig"] } {
        set ignores ""
        set ignoreF [dict get $args "-ig" ]
          set ignoreFile [open $ignoreF "r"]
            set ignLine [split [read $ignoreFile] "\n"]
            foreach line $ignLine {
                if { $line != "" } {
                    append ignores $line "|"
                }
            }
        close $ignoreFile
        regsub -all {\|$} $ignores {} ignore

    }
    puts "Ignore : $ignore"
########################################################################################################


## reading input file ##################################################################################
    set inputFile [dict get $args "-i"]
    set inFile [open $inputFile "r"]
    set lines [split [read $inFile] "\n"]
    close $inFile
########################################################################################################


## reading pattern file content #######################################################################
    set patterns ""
    set patternF [dict get $args "-p"] 
    set patternFile [open $patternF "r"]
        set pattLine [split [read $patternFile] "\n"]
        foreach line $pattLine {
            if { $line != "" } {
                append patterns $line "|"
            }
        }
    close $patternFile

    ## check pattern existence
    if { $patterns == "" } {
        usage
        return
    }

    regsub -all {\|$} $patterns {} pattern
    puts "Pattern: $pattern"
##########################################################################################################
      

## creating output file and fill matched lines into file ################################################
    set outputFile [dict get $args "-o"]
    # filling matched lines to list
    set lineList ""

    set fileMess ""
    set fileMessage [open "fileMessage.txt" "w"]
    foreach line $lines {
        if { [regexp -nocase $pattern $line message] } {
            if { [regexp {\((\w+\-\d+)\)$} $line match m] } {
                puts $fileMessage "$message $m"
                lappend fileMess "$message $m"
            }
            lappend lineList $line
        }
    }
    close $fileMessage
###########################################################################################################


### count every repitation of meaasge ######################################################################
    set flag 1 
    set count 0
    set messUnique ""
    foreach line $fileMess {
        set keyValue [split $line " "]
        set key [lindex $keyValue 0]
        set value [lindex $keyValue 1]

        if { $flag == 1 } {
            set unique $value

        }
        set flag 0
        incr count
        if { $value != $unique} {
           lappend messUnique "$key $unique $count"
           set flag 1
           set count 0

        }

    }
#############################################################################################################


## write in outpot file matched unique lines ###############################################################
    set unicLineList [lsort -unique $lineList]
    set outFile [open $outputFile "w"]

    ## Info about matched, dublicated and uniq lines.
    set unicLines [llength $unicLineList]
    set totalMatchedLines [llength $lineList]
    set ignoreLinesCount 0
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
    close $outFile

##############################################################################################################
   
    puts "  Ignored lines count : $ignoreLinesCount\n"
###################### print Name of messages code ##########################################################

#Reading out.txt file line by line and checking *.n file to filter only name part from the code description. 

set path "/pga/synopsys/pts/M-2017.06-SP3-1/doc/pt/man/catn/"
#set path "C:\\ActiveTcl\\bin"

set fp [open "fileMessage.txt" r]
while {[gets $fp data] >= 0} {
   if [regexp {(([A-Z]*)\-[0-9]*)} "$data" code match code_name = 1] {
	     
	    #puts $code_name
		#puts $match
	
	    #Opening *.n files
        set fpp [open "$path$code_name/$match\.n" r]
        #set fpp [open "$path\\$code_name\\$match\.n" r]
		set variable_man [read $fpp]
		close $fpp
        if [regexp   {^((.*?))DDEESSCCRRIIPPTTIIOONN} "$variable_man" code_1 match_1 = 1] {
	        if [regexp {NNAAMMEE\s+((.*?))} $match_1 descrip name_part = 1] {
                set name_part [join [split $name_part \n] {}]
				#puts $name_part
		        regsub -all {\s*\n\s*\n(\s*\n)*} $name_part "" name_part
				set fd [open "out_final.txt" "a+"]
                puts $fd "$data    $name_part"
				close $fd
		    }		 
        }
    }
}
close $fp





exec echo "Pattern KeyMessage Count Description" > output_final.txt
exec cat out_final.txt | uniq  >> output_final.txt

