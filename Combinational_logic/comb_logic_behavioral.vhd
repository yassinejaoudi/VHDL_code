-- Behavioral combinational logic
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comb_logic_behavioral is
	port(
		A				: in std_logic;
		B				: in std_logic;
		C				: in std_logic;
		D				: in std_logic;
		F				: out std_logic_vector(3 downto 0)
	);
end comb_logic_behavioral;

architecture behavior of comb_logic_behavioral is
	signal inputs: std_logic_vector(3 downto 0);
	
	begin
	
	inputs <= A & B & C & D;
	comb_logic_behavioral_proc: process(inputs)
		begin
			case inputs is 
				when "0000" => F <= "1011";
				when "0001" => F <= "0111";
				when "0010" => F <= "1001";
				when "0011" => F <= "1111";
				when "0100" => F <= "0000";
				when "0101" => F <= "1111";
				when "0110" => F <= "0100";
				when "0111" => F <= "1010";
				when "1000" => F <= "0100";
				when "1001" => F <= "0111";
				when "1010" => F <= "1011";
				when "1011" => F <= "1000";
				when "1100" => F <= "0100";
				when "1101" => F <= "1010";
				when "1110" => F <= "1101";
				when "1111" => F <= "0101";
				when others => F <= (others => 'X');
			end case;
	end process comb_logic_behavioral_proc;
end behavior;
