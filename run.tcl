	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"Test_Bench"
	set src_path			"Source"
	
	set run_time			"-all"

#============================ Add verilog files  ===============================

	vlog 	+acc -source  +define+SIM -O0	$src_path/*.v
	vlog 	+acc -source  +define+SIM -O0	Testbench/$TB.v

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================

	add wave -Binary  -group 	 	{TB}				sim:/$TB/*
	add wave -Binary  -group 	 	{top}				sim:/$TB/test/*
	add wave -Binary  -group -r	    {all}				sim:/$TB/*
	add wave -Decimal -group -r	    {RF}				sim:/$TB/test/id_stage/register_file/registers
	add wave -Binary  -group -r	    {SC}				sim:/$TB/test/mem_stage/sc/wr_en
	add wave -Binary  -group -r	    {SC}				sim:/$TB/test/mem_stage/sc/SRAM_WE_N
	add wave -Decimal -group -r	    {SC}				sim:/$TB/test/mem_stage/sc/address
	add wave -Decimal -group -r	    {SC}				sim:/$TB/test/mem_stage/sc/writeData
	add wave -Decimal -group -r	    {SC}				sim:/$TB/test/mem_stage/sc/SRAM_DQ
	add wave -Decimal -group -r	    {SC}				sim:/$TB/test/mem_stage/sc/SRAM_ADDR
	add wave -Decimal -group -r	    {SC}				sim:/$TB/test/mem_stage/sc/ps
	add wave -Decimal -group -r	    {SC}				sim:/$TB/test/mem_stage/sc/ns
	add wave -Binary  -group -r	    {SC}				sim:/$TB/test/mem_stage/sc/ready
	add wave -Binary  -group -r	    {Sram}				sim:/$TB/sram/sram_we_n
	add wave -Decimal -group -r	    {Sram}				sim:/$TB/sram/memory

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
	WaveRestoreZoom {0 ps} {15761 ps}
    
#====================================== run =====================================

	run $run_time
	