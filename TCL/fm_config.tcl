source $PROJ_HOME/implementation/scripts/asic/syn/scripts/dc_procs.tcl
set top_design  "DUMMY_MODULE" 


#set FM_SHELL_PATH "/pga/synopsys/fm/M-2016.12-SP4/bin"
set FM_SHELL_PATH "/pga/synopsys/fm/O-2018.06/bin"

set date 		  [clock sec]
set date2		  "[clock format $date -format %m.%d.%y_%H:%M:%S]"

set RUN_DATE              $date2
set TOP_LEVEL_DESIGN      "DUMMY_MODULE"
set REF_TOP_LEVEL_DESIGN  "DUMMY_MODULE"
set IMPL_TOP_LEVEL_DESIGN "DUMMY_MODULE"
set RUN_NAME              "rtl_to_prelayout_${TOP_LEVEL_DESIGN}"
set RUN_DIR               "${RUN_DATE}_${RUN_NAME}"
##set REPORT_DIR            "${RUN_DIR}/reports"
set REPORT_DIR            "reports"


set RTL_FILES_LIST	[list \
			 ${F_FILES_RTL}/mem_wrap.f \
			 ${F_FILES_RTL}/fe2_pg4_rtl.f \
			 ${F_FILES_RTL}/fe2_pg4_lib.f \
			 ${F_FILES_RTL}/acm_top_syn.f \
			 ${F_FILES_RTL}/fe2_pg4_syn.f \
			 ${F_FILES_RTL}/ddr_subsys_syn.f \
			 ${F_FILES_RTL}/fe2cs_top_syn.f \
			 ${F_FILES_RTL}/brcm_core_syn.f \
			]
                            

#set I_DESIGN "[glob /home/ess_develop_pg4/common/layout/sdh_v2/netlist/*gv]"

set I_DESIGN " /home/ess_develop_pg4/common/layout/sdh_v2/netlist/${top_design}_release.gv"  
                            

 if {[info exist RTL_FILES_LIST]} {
         echo " using RTL_FILES_LIST defined in the syn_config.tcl. Not reading  design from rtl.vc and not using BLOCK_RTL_FILES_LIST variable"
         set v_list "" 
         foreach file_ $RTL_FILES_LIST {
            if [regexp {\.v\s*$|\.vg\s*$|\.sv\s*$|\.gv\s*$|\.vp\s*$|\.svh\s*$|\.vh\s*$} $file_] {
               echo "Processing $file_ " 
               set v_list [concat $v_list $file_]
            } elseif [regexp {\.lst$|\.f$} $file_ ] {
               echo "Expanding block file list $file_"
               set exp_list [expand_file_lst $file_]
               set v_list [concat $v_list $exp_list ]
            } else {
               put_msg "the RTL_FILES_LIST should only have a .v, .vg, .gv, .sv or a .lst file (RTL file list)."
               put_msg "Cannot understand $file_. Skipping......."
           }
        }
}




#echo "$search_path"

exec mkdir $RUN_DIR
cd $RUN_DIR
exec mkdir reports
cd ..


                         





