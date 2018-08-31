library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity FFT_Control_3 is
end FFT_Control_3;

architecture tb of FFT_Control_3 is
	signal clk	: std_logic := '0';
	signal rst	: std_logic := '1';
	signal s_axis_data_tdata	: std_logic_vector(31 downto 0);
	signal s_axis_config_tready	: std_logic;
	signal s_axis_data_tready	: std_logic;
	signal m_axis_data_tvalid   : std_logic;
	signal m_axis_data_tuser    : std_logic_vector(31 downto 0);
	
	signal data_re	: std_logic_vector(31 downto 0);
    signal data_im	: std_logic_vector(31 downto 0);
begin
	dut : entity work.FFT_Control_3 port map(
    clk                    => clk,
    s_axis_data_tdata      => s_axis_data_tdata,
    s_axis_config_tready   => s_axis_config_tready,
    s_axis_data_tready     => s_axis_data_tready,
    data_out_re            => data_re,
    data_out_im            => data_im,
    m_axis_data_tvalid     => m_axis_data_tvalid,
    m_axis_data_tuser      => m_axis_data_tuser
	);

	clk <= not clk after 10 ns;
	rst <= '0' after 200 ns;

read_input : process
	variable dre : integer;
	variable dim : integer;
	variable qre : integer;
	variable qim : integer;
	variable l : line;
	file input_file : text is in "fft_core.txt";
begin
	wait until rising_edge(clk);
	wait until falling_edge(rst);
	wait until rising_edge(clk);
	while not endfile(input_file) loop
		report "Feeding input sample ...";
		readline(input_file, l);
		read(l, dre);
		read(l, dim);
		report "Re: " & integer'image(dre) & " Im: " & integer'image(dim);

		s_axis_data_tdata <= std_logic_vector(to_signed(dre,d_width));
--		d_im <= std_logic_vector(to_signed(dim,d_width));
		wait until rising_edge(clk);
		report "... done.";

	end loop;
	wait;
end process;

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
		write(lo, to_integer(signed(data_re)));
		write(lo, space);
		write(lo, to_integer(signed(data_im)));
		writeline(output_file, lo);
	end if;
end process;

end tb;
