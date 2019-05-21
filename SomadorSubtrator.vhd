LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_UNSIGNED.all;

entity SomadorSubtrator is
	generic(N: integer := 8);
	port(
		A, B: in std_logic_vector(N-1 downto 0);
		sel: in std_logic;
		S: out std_logic_vector(N-1 downto 0)
		);
end SomadorSubtrator;

architecture arch_somaSub of SomadorSubtrator is
begin
	S <= A + B when sel = '0' 
	else A - B when sel = '1';	 
end arch_somaSub;
