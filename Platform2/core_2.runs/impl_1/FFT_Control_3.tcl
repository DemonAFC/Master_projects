proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/core_2/core_2.cache/wt [current_project]
  set_property parent.project_path C:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/core_2/core_2.xpr [current_project]
  set_property ip_output_repo C:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/core_2/core_2.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  add_files -quiet C:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/core_2/core_2.runs/synth_1/FFT_Control_3.dcp
  add_files -quiet c:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/Design/IP_Core/FFT/FFT/FFT.dcp
  set_property netlist_only true [get_files c:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/Design/IP_Core/FFT/FFT/FFT.dcp]
  read_xdc -mode out_of_context -ref FFT -cells U0 c:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/Design/IP_Core/FFT/FFT/FFT_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/Design/IP_Core/FFT/FFT/FFT_ooc.xdc]
  read_xdc C:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/core_2/core_2.srcs/constrs_2/new/core_2.xdc
  link_design -top FFT_Control_3 -part xc7a35tftg256-1
  write_hwdef -file FFT_Control_3.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force FFT_Control_3_opt.dcp
  catch { report_drc -file FFT_Control_3_drc_opted.rpt }
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force FFT_Control_3_placed.dcp
  catch { report_io -file FFT_Control_3_io_placed.rpt }
  catch { report_utilization -file FFT_Control_3_utilization_placed.rpt -pb FFT_Control_3_utilization_placed.pb }
  catch { report_control_sets -verbose -file FFT_Control_3_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force FFT_Control_3_routed.dcp
  catch { report_drc -file FFT_Control_3_drc_routed.rpt -pb FFT_Control_3_drc_routed.pb -rpx FFT_Control_3_drc_routed.rpx }
  catch { report_methodology -file FFT_Control_3_methodology_drc_routed.rpt -rpx FFT_Control_3_methodology_drc_routed.rpx }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file FFT_Control_3_timing_summary_routed.rpt -rpx FFT_Control_3_timing_summary_routed.rpx }
  catch { report_power -file FFT_Control_3_power_routed.rpt -pb FFT_Control_3_power_summary_routed.pb -rpx FFT_Control_3_power_routed.rpx }
  catch { report_route_status -file FFT_Control_3_route_status.rpt -pb FFT_Control_3_route_status.pb }
  catch { report_clock_utilization -file FFT_Control_3_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force FFT_Control_3_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

