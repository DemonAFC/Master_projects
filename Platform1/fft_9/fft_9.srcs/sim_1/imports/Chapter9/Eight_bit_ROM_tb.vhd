library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all; 
use ieee.std_logic_textio.all;

entity Eight_bit_ROM_tb is
end Eight_bit_ROM_tb;

architecture dataflow of Eight_bit_ROM_tb is

component fft_rom

port (clk : in std_logic;
  address : in std_logic_vector (7 downto 0);
--  temp : out signed (7 downto 0);
  data : out std_logic_vector (7 downto 0) );
end component;

signal  clk1 : std_logic;
signal addr1 : std_logic_vector (7 downto 0):= "00000000";
signal data1 : std_logic_vector (7 downto 0);
signal count: integer := 0;

begin
--UUT: fft_rom port map(clk =>clk1, address => addr1, temp => temp, data => data1);
UUT: fft_rom port map(clk =>clk1, address => addr1, data => data1);
		 
process
begin

wait for 100 ns;
clk1 <='0';                                                        
wait for 100 ns;
clk1 <='1';	  
if (count = 0) then
    addr1 <= addr1 + 1;
    if (addr1 = 255) then 
        count <= 1;
    end if;
end if;
end process;

end dataflow;
