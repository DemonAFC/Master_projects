@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 776a39745dc14fb88b773e1207cce5eb -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot fft_tb_behav xil_defaultlib.fft_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
