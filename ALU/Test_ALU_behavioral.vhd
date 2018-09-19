library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
USE ieee.math_real.ALL; 

entity test_ALU_behavioral is
end;

architecture test of test_ALU_behavioral is

component ALU_behavioral
generic(
		bit_depth : integer := 8);
port(
		result : out std_logic_vector(bit_depth-1 downto 0);
		Error : out std_logic;
		A : in std_logic_vector(bit_depth-1 downto 0);
		B : in std_logic_vector(bit_depth-1 downto 0);
		OpCode : in std_logic_vector(3 downto 0)
	);
end component;

constant bit_depth	: integer := 4;
constant period : time :=10 ns;
signal test_result :	std_logic_vector(bit_depth-1 downto 0);
signal test_Error :	std_logic;
signal test_A :	std_logic_vector(bit_depth-1 downto 0);
signal test_B :	std_logic_vector(bit_depth-1 downto 0);
signal test_OpCode : std_logic_vector(3 downto 0);

begin
	dev_to_test : ALU_behavioral
	port map (
        result => test_result,
        Error => test_Error,
        A => test_A,
        B => test_B,
        OpCode => test_OpCode
	);
	
    stimulus : process	
    begin 
	    test_A <= "00100101"; 
	    test_B <= "00001010"; 
	    test_OpCode <= "0000";
		wait for period;
	    test_OpCode <= "0001";
		wait for period;
	    test_OpCode <= "0010";
		wait for period;
	    test_OpCode <= "0011";
		wait for period;
	    test_OpCode <= "0100";
		wait for period;
	    test_OpCode <= "0101";
		wait for period;
--		test_A <= "00001000"; -- 8
--	    test_B <= "00000101"; -- 5
	    test_OpCode <= "0110"; 
		wait for period;
	    test_OpCode <= "0111";
		wait for period;
	    test_OpCode <= "1000";
		wait for period;
	    test_OpCode <= "1001";
		wait for period;
	    test_OpCode <= "1010";
		wait for period;
	    test_OpCode <= "1011";
		wait for period;
		wait;
	end process stimulus;
end test;