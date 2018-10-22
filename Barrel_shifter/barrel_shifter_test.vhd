-- Barrel Shifter Testbench
library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity barrel_shifter_test is
end barrel_shifter_test;

architecture test of barrel_shifter_test is
component barrel_shifter

port(
		input:			in std_logic_vector(7 downto 0);
		shift: 			in std_logic_vector(2 downto 0);
		opcode: 		in std_logic_vector(1 downto 0);
		clk:			in std_logic;
		reset:			in std_logic;
		reg:			out std_logic_vector(7 downto 0)
);

end component;

constant period : time :=10 ns;
signal rst:					std_logic:='0';
signal clk_sig:				std_logic:='1';
signal reg_out, data_in, reg_expected:	std_logic_vector(7 downto 0);
signal opc:					std_logic_vector(1 downto 0);
signal shift_sig:			std_logic_vector(2 downto 0);

begin
	dev_to_test : barrel_shifter
	port map (
		reset => rst,
		clk => clk_sig,
		shift => shift_sig,
		input => data_in,
		opcode => opc,
		reg => reg_out
	);
	
	clk_proc : process
		begin
			clk_sig <= not clk_sig;
			wait for period;
	end process clk_proc;
	
	stimulus: process
	begin
		data_in <= "01011111";
	    opc <= "01"; -- Load input
		wait for period;
	    opc <= "00"; -- Hold data
		wait for period;
		-- SL with 2 bits
	    opc <= "10"; -- Rotate left
		shift_sig <= "010";
		wait for period;
		-- SR with 4 bits
	    opc <= "11"; -- Rotate right
		shift_sig <= "100";
		wait for period;
		-- SR with 1 bit 
	    opc <= "11";
		shift_sig <= "001";
		wait for period;
		-- SL with 3 bits
	    opc <= "10";
		shift_sig <= "011";
		wait for period;
		-- SL with 0 bits
	    opc <= "10";
		shift_sig <= "000";
		wait for period;
	end process stimulus;
	
	evalStimulus: process
	variable ErrCnt : integer := 0;
	variable WriteBuf : line;
	begin
		--data_in <= "01011111";
		if(opc = '01') then
			reg_expected <= "01011111";
			if (reg_out /= reg_expected) then
				write(WriteBuf, string'("Error test failed at opc load"));
				writeline(Output, WriteBuf);
				ErrCnt := ErrCnt+1;
			end if;
		elsif(opc = '00') then
			reg_expected <= "01011111";
			if(reg_out /= reg_expected) then
				write(WriteBuf, string'("Error test failed at opc hold"));
				writeline(Output, WriteBuf);
				ErrCnt := ErrCnt+1;
			end if;
		elsif(opc = '10') then
			if(shift_sig = '010') then
				reg_expected <= "01111101";
				if(reg_out /= reg_expected) then
					write(WriteBuf, string'("Error test failed at opc SL two bits"));
					writeline(Output, WriteBuf);
					ErrCnt := ErrCnt+1;
				end if;
			end if;
		elsif(opc = '10') then
			if(shift_sig = '011') then
				reg_expected <= "01011111";
				if(reg_out /= reg_expected) then
					write(WriteBuf, string'("Error test failed at opc SL two bits"));
					writeline(Output, WriteBuf);
					ErrCnt := ErrCnt+1;
				end if;
			end if;
		elsif(opc = '10') then
			if(shift_sig = '000') then
				reg_expected <= "01011111";
				if(reg_out /= reg_expected) then
					write(WriteBuf, string'("Error test failed at opc SL zero bits"));
					writeline(Output, WriteBuf);
					ErrCnt := ErrCnt+1;
				end if;
			end if;
		elsif(opc = '11') then
			if(shift_sig = '100') then
				reg_expected <= "11010111";
				if(reg_out /= reg_expected) then
					write(WriteBuf, string'("Error test failed at opc SR four bits"));
					writeline(Output, WriteBuf);
					ErrCnt := ErrCnt+1;
				end if;
			end if;
		elsif(opc = '11') then
			if(shift_sig = '001') then
				reg_expected <= "11101011";
				if(reg_out /= reg_expected) then
					write(WriteBuf, string'("Error test failed at opc SR one bit"));
					writeline(Output, WriteBuf);
					ErrCnt := ErrCnt+1;
				end if;
			end if;
		end if;
		
		if(ErrCnt = 0) then
			report "Success!! Barrel shifter test completed";
		else
			report "barrel shifter is broken" severity warning;
		end if;
	end process evalStimulus
end test;