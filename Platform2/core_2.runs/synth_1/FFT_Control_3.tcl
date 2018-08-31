# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tftg256-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/core_2/core_2.cache/wt [current_project]
set_property parent.project_path C:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/core_2/core_2.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/core_2/core_2.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files C:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/Design/IP_Core/cos_14_1024_signed.coe
add_files -quiet c:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/Design/IP_Core/FFT/FFT/FFT.dcp
set_property used_in_implementation false [get_files c:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/Design/IP_Core/FFT/FFT/FFT.dcp]
read_verilog -library xil_defaultlib C:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/Design/Code/FFT_Control_3.v
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/core_2/core_2.srcs/constrs_2/new/core_2.xdc
set_property used_in_implementation false [get_files C:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/core_2/core_2.srcs/constrs_2/new/core_2.xdc]


synth_design -top FFT_Control_3 -part xc7a35tftg256-1


write_checkpoint -force -noxdef FFT_Control_3.dcp

catch { report_utilization -file FFT_Control_3_utilization_synth.rpt -pb FFT_Control_3_utilization_synth.pb }
