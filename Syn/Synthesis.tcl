for {set i 10} {$i < 20} {set i [expr {$i+0.5}]} {
#SETUP
	set company "CIC"
	set designer "Student"
	set search_path      "/usr/cad/CBDK/CBDK_IC_Contest_v2.1/SynopsysDC/db $search_path"
	set target_library   "slow.db"
	set link_library     "* $target_library dw_foundation.sldb"
	set symbol_library   "tsmc13.sdb generic.sdb"
	set synthetic_library "dw_foundation.sldb"

	set hdlin_translate_off_skip_text "TRUE"
	set edifout_netlist_only "TRUE"
	set verilogout_no_tri true

	set hdlin_enable_presto_for_vhdl "TRUE"
	set sh_enable_line_editing true
	set sh_line_editing_mode emacs
	history keep 100
	alias h history

	set bus_inference_style {%s[%d]}
	set bus_naming_style {%s[%d]}
	set hdlout_internal_busses true
	define_name_rules name_rule -allowed {a-z A-Z 0-9 _} -max_length 255 -type cell
	define_name_rules name_rule -allowed {a-z A-Z 0-9 _[]} -max_length 255 -type net
	define_name_rules name_rule -map {{"\\*cell\\*" "cell"}}

	set view_script_submenu_items [list {Avoid assign statement} {set_fix_multiple_p
	ort_nets -all -buffer_constant} {Change Naming Rule} {change_names -rule verilog
	 -hierarchy} {Write SDF} {write_sdf -version 2.1 -context verilog chip.sdf}]  
	read_file -format verilog {/home/arthur/arthur/IC_2016/Exercise/LBP.v}
	uplevel #0 check_design
#TIMING
	# operating conditions and boundary conditions #

	set cycle  $i         ;#clock period defined by designer

	create_clock -period $cycle [get_ports  clk]
	set_dont_touch_network      [get_clocks clk]
	set_clock_uncertainty  0.1  [get_clocks clk]
	set_clock_latency      0.5  [get_clocks clk]

	set_input_delay  5      -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
	set_output_delay 0.5    -clock clk [all_outputs] 
	set_load         1     [all_outputs]
	set_drive        1     [all_inputs]

	set_operating_conditions -max_library slow -max slow
	set_wire_load_model -name tsmc13_wl10 -library slow                        

	set_max_fanout 20 [all_inputs]
#Compile
	compile
	uplevel #0 { report_timing -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group } >> [format "timing%f.txt" $i]
	uplevel #0 { report_area } >> [format "area%f.txt" $i]
	uplevel #0 { report_power -analysis_effort low } >> [format "power%f.txt" $i]
	remove_design -designs
}

