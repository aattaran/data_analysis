#!/usr/bin/tclsh

####################################################################################
##  Author : Veena Ramamurthy. (veena.ramamurthy@sandisk.com)
##  Supporting script to run lec
##  Usage: create_lec_dir.tcl <module_name>
##  Called by Make file under functional/module directory
##  Creates <module_name>/lec directory
##  Copies dofiles and run lec script 
##  Links necasary synopsys setup files to <module_name>/syn directory
##  Checks in and commits the directories and files into SVN
#####################################################################################


if {$argc != 2} {
	puts " ERROR: Module name not specified. Exiting...."
	exit
} else {
	set module [lindex $argv 0]
	set svn [lindex $argv 1]
}

set NETLIST_STAGE  $env(LEC_NETLIST_STAGE)
set LEC_REV        $env(LEC_REV)       
set DEBUG          $env(LEC_DEBUG)        
set ECO_MODE       $env(ECO_MODE)         
set ROOT           $env(ROOT)         
set LEC_SCR_ROOT   $env(LEC_SCR_ROOT)         

if {$ECO_MODE == TRUE} {
set main_dir $module/lec/${NETLIST_STAGE}/ECO
} else {
set main_dir $module/lec/${NETLIST_STAGE}
}

if [file exists $main_dir] {  
	puts "INFO -> $main_dir directory exists.Assuming that the directory is in SVN\n"
} else {
	if {![file exists $module]} {
		file mkdir $module
		if {$svn} {
			exec svn add $module
			exec svn commit $module -m "initial version"
		}
	}
	puts "INFO -> $main_dir does not exist. Creating the directories..."
	file mkdir $main_dir
		if {$svn} {
			exec svn add --parents $main_dir
			exec svn commit $main_dir -m "initial version"
		}
} 

cd $main_dir

set lec_dir ${LEC_SCR_ROOT}
set bin_dir ${lec_dir}/bin
set comm_dir ${lec_dir}/../../common
set templ_dir ${lec_dir}/templates

#if {![file exists  proj_config.tcl]} {
#   exec ln -s $comm_dir/proj_config.tcl . 
#}


