----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/05/2018 10:34:32 AM
-- Design Name: 
-- Module Name: fft_top - Behavioral
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
use ieee.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fft_top is
	generic (

        -- input bit width (given in bits)
        d_width     : positive := 8;
        -- FFT length (given as exponent of 2^N)
        length      : positive := 8);
        
     port ( 
  		clk	    : in std_logic;
        rst     : in std_logic;
        d_re	: out std_logic_vector(d_width-1 downto 0);
        d_im    : out std_logic_vector(d_width-1 downto 0);
        q_re	: out std_logic_vector(d_width+length-1 downto 0);
        q_im    : out std_logic_vector(d_width+length-1 downto 0));
end fft_top;

architecture Behavioral of fft_top is
    constant tf_width   : integer := 8;
    signal rom2fft_re	: std_logic_vector(0 to length-1);
	signal rom2fft_im	: std_logic_vector(d_width-1 downto 0) := "00000000";
	signal fft2out_re   : std_logic_vector(d_width+length-1 downto 0);
	signal fft2out_im   : std_logic_vector(d_width+length-1 downto 0);
	signal address      : std_logic_vector(length-1 downto 0);
	signal initaddr     : std_logic_vector(length-1 downto 0) := "00000000";
	
begin
rom2fft: entity work.fft_rom port map(  clk => clk,
                                        address => address,
                                        data => rom2fft_re);
fft_entity: entity work.fft generic map(    d_width     => d_width,
                                            tf_width    => tf_width,
                                            length    => length)
                            port map (      clk    => clk,
                                            rst    => rst,
                                            d_re   => rom2fft_re,
                                            d_im   => rom2fft_im,
                                            q_re   => fft2out_re,
                                            q_im   => fft2out_im);  
                                     
process(clk) begin
if rising_edge(clk) then
    if (initaddr < 255) then
        address <= initaddr;
        initaddr <= initaddr + 1; 
    end if;
end if;
end process;
d_re <= rom2fft_re;
d_im <= rom2fft_im;
q_re <= fft2out_re;
q_im <= fft2out_im;
end Behavioral;
