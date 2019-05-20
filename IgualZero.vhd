LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity IgualZero is
	generic(N : integer := 8);
	port(
		X : in std_logic_vector(N-1 downto 0);
		S: out std_logic
	);
end IgualZero;

architecture arch_IgualZero of IgualZero is
begin
    S <= '1' when X = (X'range => '0')
	 else '0';
end arch_IgualZero;
