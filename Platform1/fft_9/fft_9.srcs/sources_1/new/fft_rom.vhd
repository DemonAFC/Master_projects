----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/05/2018 11:08:17 AM
-- Design Name: 
-- Module Name: fft_rom - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all; 
use ieee.std_logic_textio.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fft_rom is
port(   
    clk : in std_logic;
    address : in std_logic_vector (7 downto 0);
--    temp: out signed (7 downto 0);
    data : out std_logic_vector (7 downto 0));
end fft_rom;

architecture Behavioral of fft_rom is

type ROM_type is array (0 to 255) of std_logic_vector (7 downto 0);      
shared variable ROM : ROM_type;  
begin

read_input: process
variable rdline : line;
file file_input : text open read_mode is "C:/Users/Administrator/Hoang_Design/Example/fft-master/fft-master/src/fft/fft_stimulus.txt";

begin 
for i in ROM_type'range loop
  readline(file_input, rdline);
  hread(rdline, ROM(i));
  wait for 5 ns;
end loop;
wait;
end process;

process(clk) begin
if rising_edge(clk) then
--    data <= std_logic_vector(temp);
    data <= ROM(to_integer(unsigned(address)));
--     data <= std_logic_vector(temp);
end if;

end process;

end Behavioral;

