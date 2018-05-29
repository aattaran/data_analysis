#
# Master constraints for the ORCA chip for functional mode
#

# Time Unit: ns
# Cap Unit : pf


# Create test clocks
create_clock -period 100 -w {45 55} -name test_SDRAM_CLK [get_ports test_sdram_clk]
create_clock -period 100 -w {45 55} -name test_SYS_CLK [get_ports test_sys_clk]
create_clock -period 100 -w {45 55} -name test_PCI_CLK [get_ports test_pci_clk]
create_clock -period 100 -w {45 55} -name test_SYS_2x_CLK [get_ports test_sys2x_clk]
create_clock -period 100 -w {45 55} -name test_REGFILE_CLK [get_ports test_regfile_clk]

# Create test reset clock
set_case_analysis 1 [get_ports prst_n]

# Create functional clocks

# PCI clock at 66 MHz
create_clock -period 15 -name pclk [get_ports pclk]
# System clock at 100 MHz
create_clock -period 10 -name sys_clk [get_ports sys_clk]
# sdram clock at 133 MHz
create_clock -period 7.5 -name sdr_clk [get_ports sdr_clk]

# System clocks from internal clock multiplier
create_generated_clock \
    -source [get_ports sys_clk] \
    -multiply_by 1 \
    -name SYS_CLK \
    [get_pins I_CLOCK_GEN/I_CLKMUL/clk_1x]

create_generated_clock \
    -source [get_ports sys_clk] \
    -multiply_by 2 \
    -name SYS_2x_CLK \
    [get_pins I_CLOCK_GEN/I_CLKMUL/clk_2x]

# Internal PLL PCI clock
create_generated_clock \
    -source [get_ports pclk] \
    -multiply_by 1 \
    -name PCI_CLK \
    [get_pins I_CLOCK_GEN/I_PLL_PCI/clk] 

# Internal PLL SDRAM clock
create_generated_clock \
    -source [get_ports sdr_clk] \
    -multiply_by 1 \
    -name SDRAM_CLK \
    [get_pins I_CLOCK_GEN/I_PLL_SD/clk]

# Create PLL feedback clocks for constraining IOs:
create_generated_clock \
    -source [get_pins I_CLOCK_GEN/I_PLL_PCI/clk] \
    -multiply_by 1 \
    -name IO_PCI_CLK \
    [get_pins I_CLOCK_GEN/I_PLL_PCI/fb_clk] 

create_generated_clock \
    -source [get_pins I_CLOCK_GEN/I_PLL_SD/clk] \
    -multiply_by 1 \
    -name IO_SDRAM_CLK \
    [get_pins I_CLOCK_GEN/I_PLL_SD/fb_clk] 

# Create outgoing clocks for DDR interface
create_generated_clock \
    -source [get_pins I_CLOCK_GEN/I_PLL_SD/clk] \
    -divide_by 1 \
    -name SD_DDR_CLK \
    [get_ports sd_CK]
create_generated_clock \
    -source [get_pins I_CLOCK_GEN/I_PLL_SD/clk] \
    -divide_by 1 -invert \
    -name SD_DDR_CLKn \
    [get_ports sd_CKn]

# Setup asynchronous clock groups    
set pclk_clocks [get_clocks "PCI_CLK IO_PCI_CLK pclk"]
set sdr_clocks [get_clocks "SDRAM_CLK IO_SDRAM_CLK SD_DDR_CLK sdr_clk"]
set sys_clocks [get_clocks "SYS_CLK SYS_2x_CLK sys_clk"]

set_false_path -from $pclk_clocks -to [add_to_collection $sdr_clocks $sys_clocks]
set_false_path -from [add_to_collection $sdr_clocks $sys_clocks] -to $pclk_clocks
set_false_path -from $sdr_clocks -to $sys_clocks
set_false_path -from $sys_clocks -to $sdr_clocks

set_propagated_clock [all_clocks]

# Constrain interface
set pci_io_ports [get_ports p* -filter "port_direction==inout"]
set pci_in_ports [add_to_collection [get_ports "pidsel pgnt_n pm66en"] $pci_io_ports]
set pci_out_ports [add_to_collection [get_ports "preq_n"] $pci_io_ports]
set pci_ports [add_to_collection $pci_io_ports [get_ports "pidsel pgnt_n pm66en preq_n"] ]


set sd_io_ddr_ports [get_ports "sd_DQ*"]
set sd_out_ports [remove_from_collection [get_ports sd_*] \
    [add_to_collection $sd_io_ddr_ports [get_ports "sd_CK sd_CKn"]]]
set sd_ports [add_to_collection $sd_io_ddr_ports $sd_out_ports]

# Constrain PCI ports for functional clocks
set_input_delay 8 -max -clock IO_PCI_CLK -add_delay $pci_in_ports
set_input_delay 2 -min -clock IO_PCI_CLK -add_delay  $pci_in_ports
set_output_delay 4 -max -clock IO_PCI_CLK -add_delay $pci_out_ports
set_output_delay -1 -min -clock IO_PCI_CLK -add_delay $pci_out_ports
set_load 15 $pci_ports 

# Constrain SDRAM ports for functional clocks
set_input_delay 0.8 -max -add_delay -clock IO_SDRAM_CLK $sd_io_ddr_ports
set_input_delay 0.8 -max -add_delay -clock IO_SDRAM_CLK -clock_fall $sd_io_ddr_ports
set_input_delay 0.2 -min -add_delay -clock IO_SDRAM_CLK $sd_io_ddr_ports
set_input_delay 0.2 -min -add_delay -clock IO_SDRAM_CLK -clock_fall $sd_io_ddr_ports
set_output_delay 0.75 -max -add_delay -clock SD_DDR_CLK $sd_ports
set_output_delay 0.75 -max -add_delay -clock SD_DDR_CLK -clock_fall $sd_io_ddr_ports
set_output_delay -0.10 -min -add_delay -clock SD_DDR_CLK $sd_ports
set_output_delay -0.10 -min -add_delay -clock SD_DDR_CLK -clock_fall $sd_io_ddr_ports
set_load 20 $sd_ports
set_load 5 [get_ports "sd_CK sd_CKn"]

# Set all input transitions
set_input_transition 0.5 [all_inputs]
set_input_transition 1 $pci_in_ports

# Set up constraints for clock gating in Blender design
set_clock_gating_check -setup 0.2 -hold 0.2  [get_clocks SYS_CLK]


# Setup gating checks for DDR interface
# Mux pins are known, therefore setting gating checks directly 
set all_D1_mux_pins "I_ORCA_TOP/I_SDRAM_IF/U1175/D1 I_ORCA_TOP/I_SDRAM_IF/U1176/D1 I_ORCA_TOP/I_SDRAM_IF/U1178/D1 \
         I_ORCA_TOP/I_SDRAM_IF/U1179/D1 I_ORCA_TOP/I_SDRAM_IF/U1180/D1 I_ORCA_TOP/I_SDRAM_IF/U1181/D1 \
         I_ORCA_TOP/I_SDRAM_IF/U1182/D1 I_ORCA_TOP/I_SDRAM_IF/U1183/D1 I_ORCA_TOP/I_SDRAM_IF/U1184/D1 \
         I_ORCA_TOP/I_SDRAM_IF/U1185/D1 I_ORCA_TOP/I_SDRAM_IF/U1186/D1 I_ORCA_TOP/I_SDRAM_IF/U1187/D1 \
         I_ORCA_TOP/I_SDRAM_IF/U1189/D1 I_ORCA_TOP/I_SDRAM_IF/U1190/D1 I_ORCA_TOP/I_SDRAM_IF/U1191/D1 \
         I_ORCA_TOP/I_SDRAM_IF/U1192/D1 I_ORCA_TOP/I_SDRAM_IF/U1193/D1 I_ORCA_TOP/I_SDRAM_IF/U1194/D1 \
         I_ORCA_TOP/I_SDRAM_IF/U1195/D1 I_ORCA_TOP/I_SDRAM_IF/U1196/D1 I_ORCA_TOP/I_SDRAM_IF/U1197/D1 \
         I_ORCA_TOP/I_SDRAM_IF/U1198/D1 I_ORCA_TOP/I_SDRAM_IF/U1168/D1 I_ORCA_TOP/I_SDRAM_IF/U1169/D1 \
         I_ORCA_TOP/I_SDRAM_IF/U1170/D1 I_ORCA_TOP/I_SDRAM_IF/U1171/D1 I_ORCA_TOP/I_SDRAM_IF/U1172/D1 \
         I_ORCA_TOP/I_SDRAM_IF/U1173/D1 I_ORCA_TOP/I_SDRAM_IF/U1174/D1 I_ORCA_TOP/I_SDRAM_IF/U1177/D1 \
         I_ORCA_TOP/I_SDRAM_IF/U1188/D1 I_ORCA_TOP/I_SDRAM_IF/U1199/D1"
set all_D0_mux_pins "I_ORCA_TOP/I_SDRAM_IF/U1175/D0 I_ORCA_TOP/I_SDRAM_IF/U1176/D0 I_ORCA_TOP/I_SDRAM_IF/U1178/D0 \
         I_ORCA_TOP/I_SDRAM_IF/U1179/D0 I_ORCA_TOP/I_SDRAM_IF/U1180/D0 I_ORCA_TOP/I_SDRAM_IF/U1181/D0 \
         I_ORCA_TOP/I_SDRAM_IF/U1182/D0 I_ORCA_TOP/I_SDRAM_IF/U1183/D0 I_ORCA_TOP/I_SDRAM_IF/U1184/D0 \
         I_ORCA_TOP/I_SDRAM_IF/U1185/D0 I_ORCA_TOP/I_SDRAM_IF/U1186/D0 I_ORCA_TOP/I_SDRAM_IF/U1187/D0 \
         I_ORCA_TOP/I_SDRAM_IF/U1189/D0 I_ORCA_TOP/I_SDRAM_IF/U1190/D0 I_ORCA_TOP/I_SDRAM_IF/U1191/D0 \
         I_ORCA_TOP/I_SDRAM_IF/U1192/D0 I_ORCA_TOP/I_SDRAM_IF/U1193/D0 I_ORCA_TOP/I_SDRAM_IF/U1194/D0 \
         I_ORCA_TOP/I_SDRAM_IF/U1195/D0 I_ORCA_TOP/I_SDRAM_IF/U1196/D0 I_ORCA_TOP/I_SDRAM_IF/U1197/D0 \
         I_ORCA_TOP/I_SDRAM_IF/U1198/D0 I_ORCA_TOP/I_SDRAM_IF/U1168/D0 I_ORCA_TOP/I_SDRAM_IF/U1169/D0 \
         I_ORCA_TOP/I_SDRAM_IF/U1170/D0 I_ORCA_TOP/I_SDRAM_IF/U1171/D0 I_ORCA_TOP/I_SDRAM_IF/U1172/D0 \
         I_ORCA_TOP/I_SDRAM_IF/U1173/D0 I_ORCA_TOP/I_SDRAM_IF/U1174/D0 I_ORCA_TOP/I_SDRAM_IF/U1177/D0 \
         I_ORCA_TOP/I_SDRAM_IF/U1188/D0 I_ORCA_TOP/I_SDRAM_IF/U1199/D0"

set_clock_gating_check -high -setup 0 -hold 0 $all_D1_mux_pins
set_clock_gating_check -low -setup 0 -hold 0 $all_D0_mux_pins

# Disable the gating check data paths from propagating past the mux
set timing_clock_gating_propagate_enable false

# Set a false path for all sd_DQ[0-31] output pad enable paths
for {set i 0} {$i < 32} {incr i} {
    set_false_path -from [get_pins I_ORCA_TOP/I_SDRAM_IF/sd_DQ_en_reg[$i]/CLK] \
	-through [get_pins sdram_DQ_iopad_$i/OEN]
}


