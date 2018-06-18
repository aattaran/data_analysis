#!/usr/bin/tclsh 

###############################################################################
##
## Copyright (c) 2012 SanDisk Corp.   All rights reserved.
##
## This media contains an authorized copy or copies of material copyrighted
## by SanDisk Corporation and its applicable subsidiaries.  This copyright
## notice and any other copyright notices included in machine readable copies
## must be reproduced on all authorized copies.  This is confidential and
## unpublished property of SanDisk Corporation and its applicable subsidiaries.
##
##  File Name : setup_lecdir.tcl
##  Description :
##  Author :  vramamurthy
##  Creation Date : 24-04-2014
##  Last Modified : Wed 05 Oct 2016 03:18:00 PM PDT
##
###############################################################################
#### env variables ####
set LEC_REV        $env(LEC_REV)       
set PVT_TARGET     $env(PT_CORNER)    
set NETLIST_STAGE  $env(LEC_NETLIST_STAGE)		
set DEBUG          $env(LEC_DEBUG)        
set ECO_MODE       $env(ECO_MODE)         
set ECO_ID         $env(ECO_ID)         
set LEC_SCR_ROOT   $env(LEC_SCR_ROOT)         
set ROOT           $env(ROOT)         
set LEC_COMP_TYPE  $env(LEC_COMP_TYPE)
set lec_dir        $LEC_SCR_ROOT
set svn 	   $env(SVN)		
set module 	   $env(MOD)		
set LEC_EXE 	   $env(LEC_EXE)		

#set bin_dir ${pt_dir}/bin
#set comm_dir ${pt_dir}/../common
#set templ_dir ${pt_dir}/templates

########## Creating revisions #################
puts "INFO -> STARTING REV CREATION"
if {$ECO_MODE == "FALSE"} {
puts "INFO -> ECO_MODE is FALSE"
if {$LEC_REV == "NULL"} {
  set count 0 
  set all_revs [glob -nocomplain rev_*]
  if {[llength $all_revs] > 0} { 
    foreach jj $all_revs {
     if {[regexp {^rev_+([-\.0-9]+)} $jj]} {
        set cc ""
        set cc [regsub "rev_" $jj ""] 
           if {$cc >= $count} {
         set count [expr $cc + 1]
      }
    }
  }
    set rev rev_$count
    #file mkdir $rev
  } else { 
    	set rev rev_$count
    	#file mkdir $rev  
  	}
 } else {
      set rev ${LEC_REV}
      #file mkdir $rev
   }
} else {
puts "INFO -> ECO_MODE is TRUE"
if {$LEC_REV == "NULL"} {
  set count 0 
  set all_revs [glob -nocomplain rev_${ECO_ID}_*]
  if {[llength $all_revs] > 0} { 
    foreach jj $all_revs {
     if {[regexp {^rev_ECO_+([-\.0-9]+)} $jj]} {
        set cc ""
        set cc [regsub "rev_${ECO_ID}_" $jj ""] 
     if {$cc >= $count} {
         set count [expr $cc + 1]
      }
    }
  }
    set rev rev_${ECO_ID}_$count
    #file mkdir $rev
  } else { 
    	set rev rev_${ECO_ID}_$count
    	#file mkdir $rev  
    	 }
  } else {
      set rev ${LEC_REV}
      #file mkdir $rev
  }
} 
if {$ROOT != "NULL"} {
   set rev $ROOT
}
 
set run_dir  ${rev}
  if {![file exists $run_dir]} {
       file mkdir $run_dir
      }

set lec_scr ${lec_dir}/scripts

set support_files [list lec_config.tcl \
                   ]

foreach ff $support_files {
	set mod_file $ff
	if {![file exists $mod_file]} {
		set temp_file $lec_dir/template/$ff
		set SRC [open $temp_file r]
		set DES [open $mod_file w]
		while {[gets $SRC ll] >= 0} {
			regsub -all {DUMMY_MODULE} $ll "$module" ll
			puts $DES $ll 
		}
		close $DES
		close $SRC
		#if {$svn} {
	#		exec svn add $mod_file
	#		exec svn commit $mod_file -m "initial version"
	#	}
	} else {
		puts "INFO -> $ff file already exists"	
	}
}	


cd $run_dir 
if {$module == "fel_top"} {
if {![file exists lec_compare.tcl]} {
file copy ../lec_compare.tcl lec_compare.tcl
 }
} else { 
if {![file exists lec_compare.tcl]} {
file copy ${lec_dir}/scripts/lec_compare.tcl lec_compare.tcl
}
}
exec xterm -T "$NETLIST_STAGE lec  anlysis for $rev" -e "setup CONFRML16.20.240 ; qncsub -cpu 2 -i lec -64 -xl -nogui -do  lec_compare.tcl" 2> .catchError
#exec xterm -T "$NETLIST_STAGE lec  anlysis for $rev" -e "qncsub -i ${LEC_EXE} -64 -xl -nogui -do  lec_compare.tcl | tee lec_$rev.log "
#exec xterm -T "$NETLIST_STAGE lec  anlysis for $rev" -e "lec -64 -xl -nogui -do  lec_compare.tcl | tee lec_$rev.log"
#exec qncsub -i lec -64 -xl -nogui -do  lec_compare.tcl | tee lec_$rev.log
#exec xterm -T "$NETLIST_STAGE lec  anlysis for $rev" 
cd ../
exec rm -rf current 
exec ln -sf $rev current

cd ../

#if {$svn} {
#	exec svn up $module
#}
