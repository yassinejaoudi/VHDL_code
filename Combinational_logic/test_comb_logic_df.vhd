--ECE 501
--Assignment #1
--Testbench combinational logic dataflow style

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

use std.textio.all ;
use ieee.std_logic_textio.all ;

entity test_comb_logic_df is
end;

architecture test of test_comb_logic_df is

component comb_logic_df
		Port(
				A				: in std_logic;
				B				: in std_logic;
				C				: in std_logic;
				D				: in std_logic;
				F				: out std_logic_vector (3 downto 0)
		);
end component;

signal A_in 			: std_logic := '0';
signal B_in 			: std_logic := '0';
signal C_in 			: std_logic := '0';
signal D_in 			: std_logic := '0';
signal F				: unsigned (3 downto 0);
signal F_expected		: unsigned (3 downto 0) := to_unsigned(0,4);

signal inputs			: unsigned (3 downto 0) := to_unsigned(0,4);
signal outputs			: unsigned (3 downto 0) := to_unsigned(0,4);

begin
	dev_to_test: comb_logic_df port map (
		unsigned (F) => F, A => A_in, B => B_in, C => C_in,
		D => D_in);
	
	--Test outputs; connecting to test unit ports 
	inputs <= A_in & B_in & C_in & D_in;
	F_expected <= outputs;
	
	expected_proc : process(inputs)
		begin
			case inputs is
			when "0000" => outputs <= "1011";
			when "0001" => outputs <= "0111";
			when "0010" => outputs <= "1001";
			when "0011" => outputs <= "1111";
			when "0100" => outputs <= "0000";
			when "0101" => outputs <= "1111";
			when "0110" => outputs <= "0100";
			when "0111" => outputs <= "1010";
			when "1000" => outputs <= "0100";
			when "1001" => outputs <= "0111";
			when "1010" => outputs <= "1011";
			when "1011" => outputs <= "1000";
			when "1100" => outputs <= "0100";
			when "1101" => outputs <= "1010";
			when "1110" => outputs <= "1101";
			when "1111" => outputs <= "0101";
			when others => outputs <= (others => 'X');
			end case;
	end process expected_proc;
	
	stimulus : process

	-- Variables for testbench
	variable ErrCnt : integer := 0 ;
	variable WriteBuf : line ;
	  
	begin
		for i in std_logic range '0' to '1' loop
			A_in <= i;
			for j in std_logic range '0' to '1' loop
				B_in <= j;
				for k in std_logic range '0' to '1' loop
					C_in <= k;
					for m in std_logic range '0' to '1' loop
						D_in <= m;
						
						wait for 10 ns;
						
							if(F_expected /= F) then
								write(WriteBuf, string'("ERROR  CL test failed at F: A = "));
								write(WriteBuf, A_in); write(WriteBuf, string'(", B = "));
								write(WriteBuf, B_in); write(WriteBuf, string'(", C = "));
								write(WriteBuf, C_in); write(WriteBuf, string'(", D = "));
								write(WriteBuf, D_in);
					 
								writeline(Output, WriteBuf);
								ErrCnt := ErrCnt+1;
							end if;
						
					end loop; -- m
				end loop; -- k
			end loop; -- j
		end loop; -- i
      
		if (ErrCnt = 0) then 
			report "SUCCESS!  The combinational logic for data-flow Test Completed.";
		else
			report "The combinational logic for data-flow is broken." severity warning;
		end if;
	 end process stimulus;
end test;