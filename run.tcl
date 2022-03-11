	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"Pipe_Line_Test_Bench"
	set src_path			"Source"
	
	set run_time			"-all"

#============================ Add verilog files  ===============================

	vlog 	+acc -source  +define+SIM -O0	$src_path/EXE_Stage.v
	vlog 	+acc -source  +define+SIM -O0	$src_path/EXE_Stage_Reg.v
	vlog 	+acc -source  +define+SIM -O0	$src_path/ID_Stage.v
	vlog 	+acc -source  +define+SIM -O0	$src_path/ID_Stage_Reg.v
	vlog 	+acc -source  +define+SIM -O0	$src_path/IF_Stage.v
	vlog 	+acc -source  +define+SIM -O0	$src_path/IF_Stage_Reg.v
	vlog 	+acc -source  +define+SIM -O0	$src_path/Instruction_mem.v
	vlog 	+acc -source  +define+SIM -O0	$src_path/PC.v
	vlog 	+acc -source  +define+SIM -O0	$src_path/MEM_Stage.v
	vlog 	+acc -source  +define+SIM -O0	$src_path/MEM_Stage_Reg.v
	vlog 	+acc -source  +define+SIM -O0	$src_path/WB_Stage.v
	vlog 	+acc -source  +define+SIM -O0	$src_path/WB_Stage_Reg.v
	vlog 	+acc -source  +define+SIM -O0	Testbench/$TB.v

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================

	add wave -Binary -group 	 	{TB}				sim:/$TB/*
#	add wave -Binary -group 	 	{top}				sim:/$TB/test/*
	add wave -Binary -group -r	    {all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    
#====================================== run =====================================

	run $run_time 
	