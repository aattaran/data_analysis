set sh_continue_on_error true

source ./scripts/metrics.tcl

read_verilog orca.v

redirect -file metrics.log {metrics "METRICS: Read Design" }

current_design ORCA
link

redirect -append -file metrics.log {metrics "METRICS: Linked Design"}

source orca_const_func.tcl

redirect -append -file metrics.log {metrics "METRICS: Sourced Constraints"}

# Functional mode analysis
set_case_analysis 0 [get_ports "test_mode scan_en"]
set_case_analysis 0 [get_ports power_save]
set_case_analysis 1 [get_ports pm66en]

check_timing

redirect -append -file metrics.log {metrics "METRICS: Update Timing"}
 
quit



