--ECE 501
--Assignment #1
--Combinational logic dataflow style

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comb_logic_df is
	port (
			A			: in std_logic;
			B			: in std_logic;
			C			: in std_logic;
			D			: in std_logic;
			F			: out std_logic_vector(3 downto 0)
	);
end comb_logic_df;

architecture dataflow of comb_logic_df is
	begin
	
	-- Used Kaurnagh map to simplify the outputs of the truth table
	-- Implementation of F3 = B'C + BC'D + A'BD + ACD' + A'B'D'
	F(3) <= (((not B) and C) or  (B and (not C) and D) or ((not A) and B and D) or (A and C and (not D)) or ((not A) and (not B) and (not D)));
	-- Implementation of F2 = A'C'D + BCD' + AC'D' + ABC + AB'C' + A'B'D
	F(2) <= (((not A) and (not C) and D) or (B and C and (not D)) or (A and (not C) and (not D)) or (A and B and C) or (A and (not B) and (not C)) or ((not A) and (not B) and D));
	-- Implementation of F1 = C'D + A'D + A'B'C' + AB'CD'
	F(1) <= (((not C) and D) or ((not A) and D) or ((not A) and (not B) and (not C)) or (A and (not B) and C and (not D)));
	-- Implementation of F0 = A'B' + ABC + ACD' + A'C'D + B'C'D 
	F(0) <= (((not A) and (not B)) or (A and B and C) or (A and C and (not D)) or ((not A) and (not C) and (D)) or ((not B) and (not C) and D));
end dataflow;
