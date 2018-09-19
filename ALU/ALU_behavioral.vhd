library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity ALU_behavioral is
generic(
		bit_depth : integer := 8);
port(
		result : out std_logic_vector(bit_depth-1 downto 0);
		Error : out std_logic;
		A : in std_logic_vector(bit_depth-1 downto 0);
		B : in std_logic_vector(bit_depth-1 downto 0);
		OpCode : in std_logic_vector(3 downto 0)
	);
end ALU_behavioral;

architecture behavior of ALU_behavioral is
begin
	State_op: process(A, B, OpCode)
	begin
		Error <= '0';
		case OpCode is
			-- Output A
			when "0000" => result <= A;
			-- Output B
			when "0001" => result <= B;
			-- Output A - B
			when "0010" => result <= std_logic_vector(signed(A) - signed(B));
			-- Output A + B
			when "0011" => result <= std_logic_vector(signed(A) + signed(B));
			-- Output Not A
			when "0100" => result <= not A;
			-- Output Not B
			when "0101" => result <= not B;
			-- Output shift A left by 2 bits
			when "0110" => result <= std_logic_vector(signed(A) sll 2);
			-- Output shift A right by 2 bits
			when "0111" => result <= std_logic_vector(signed(A) srl 2);
			-- Output shift B left by 2 bits
			when "1000" => result <= std_logic_vector(signed(B) sll 2);
			-- Output shift B right by 2 bits
			when "1001" => result <= std_logic_vector(signed(B) srl 2);
			-- Output A and B
			when "1010" => result <= A and B;
			-- Output A xor B
			when "1011" => result <= A xor B;
			-- Error
			when others => result <=  (others => 'ERROR');
			Error <= '1';
		end case;
	end process State_op;
end behavior;