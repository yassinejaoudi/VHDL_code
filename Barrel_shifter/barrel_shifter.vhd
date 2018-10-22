library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity barrel_shifter is
	port(
		input:			in std_logic_vector(7 downto 0);
		shift: 			in std_logic_vector(2 downto 0);
		opcode: 		in std_logic_vector(1 downto 0);
		clk:			in std_logic;
		reset:			in std_logic;
		reg:			out std_logic_vector(7 downto 0)
	);
end barrel_shifter;

architecture behavioral of barrel_shifter is
	
	signal reg_signal:		std_logic_vector(7 downto 0);
	begin
		barrel_process: process (reset, clk, opcode, shift)
			begin
				if(reset = '1') then
					reg <= "00000000";
				else
					if (clk'event and clk='1') then
					case opcode is
						when "00" => reg_signal <= reg_signal;
						when "01" => reg_signal <= input;
						when "10" => reg_signal <= std_logic_vector(rotate_left(unsigned(reg_signal),to_integer(unsigned(shift))));
						when "11" => reg_signal <= std_logic_vector(rotate_right(unsigned(reg_signal),to_integer(unsigned(shift))));
						when others => reg_signal <= (others => 'X');
					end case;
					end if;
				end if;
			reg <= reg_signal;
		end process;
end behavioral;