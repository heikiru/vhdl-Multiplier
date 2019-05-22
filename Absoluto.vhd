LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Absoluto is
	generic(N: integer := 8);
	port(
	A: in std_logic_vector(N-1 downto 0);
	S: out std_logic_vector(N-1 downto 0)
	);
end Absoluto;

architecture arch_Absoluto of Absoluto is

signal minus_one: std_logic_vector(N-1 downto 0);
signal zero: std_logic_vector(N-1 downto 0);

component SomadorSubtrator is
generic(N, M: integer := 8);
port(
	A, B: in std_logic_vector(N-1 downto 0);
	sel: in std_logic;
	S: out std_logic_vector(N-1 downto 0)
);
end component;
begin
	
	subtrator: SomadorSubtrator generic map (N) port map(zero, A, '1', minus_one);
	
	S <= minus_one when A(N-1) = '1';
	S <= A when A(N-1) = '0';
	
end arch_Absoluto;
