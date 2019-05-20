LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Mux2para1 is
	generic(N : integer := 8);
	port(
		A, B: in std_logic_vector(N-1 downto 0);
		sel: in std_logic;	
		S: out std_logic_vector(N-1 downto 0)
	);
end Mux2para1;

architecture arch_Mux2para1 of Mux2para1 is
begin
		S <= A when sel = '0';
		S <= B when sel = '1';
end arch_Mux2para1;
