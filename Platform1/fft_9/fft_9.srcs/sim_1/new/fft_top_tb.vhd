----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/05/2018 04:56:50 PM
-- Design Name: 
-- Module Name: fft_top_tb - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fft_top_tb is
end fft_top_tb;

architecture Behavioral of fft_top_tb is

component fft_top 
	generic (
        -- input bit width (given in bits)
        d_width     : positive;
        -- FFT length (given as exponent of 2^N)
        length      : positive);
     port ( 
  		clk	    : in std_logic;
        rst     : in std_logic;
        d_re	: out std_logic_vector(d_width-1 downto 0);
        d_im    : out std_logic_vector(d_width-1 downto 0);
        q_re	: out std_logic_vector(d_width+length-1 downto 0);
        q_im    : out std_logic_vector(d_width+length-1 downto 0));
end component;

constant d_width : integer := 8;
constant length : integer := 8;

signal clk	: std_logic := '0';
signal rst	: std_logic := '1';
signal RsTx : std_logic;
signal d_re	: std_logic_vector(d_width-1 downto 0);
signal d_im	: std_logic_vector(d_width-1 downto 0);
signal q_re	: std_logic_vector(d_width+length-1 downto 0);
signal q_im	: std_logic_vector(d_width+length-1 downto 0);
signal btnC : std_logic := '0';

begin
dut: entity work.fft_top	generic map (  d_width     => d_width,
                                            length      => length)
                            port map (      clk     => clk,
                                            rst     => rst,          
                                            d_re    => d_re,
                                            d_im    => d_im,
                                            q_re    => q_re,
                                            q_im    => q_im);
                                        
clk <= not clk after 100 ns;
rst <= '0' after 200 ns;

write_output : process
	variable i : integer := 0;
	variable lo : line;
	variable space : character := ' ';
	file output_file : text is out "fft_output.txt";
begin
	wait until rising_edge(clk);
	i := i + 1;
	-- write out only one block of samples
	-- (account for the stage-induced register delay here)
	if (i > ((2**length)+length) and i < 2**(length+1)+length+1) then
		write(lo, to_integer(signed(q_re)));
		write(lo, space);
		write(lo, to_integer(signed(q_im)));
		writeline(output_file, lo);
	end if;
end process;

end Behavioral;
