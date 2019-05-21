LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity registrador is
	generic(N : integer := 8);
	port(
		X : in std_logic_vector(N-1 downto 0);
		carga: in std_logic;
		clk : in std_logic;
		Y : out std_logic_vector(N-1 downto 0)
	);
end registrador;

architecture arch_registrador of registrador is
begin
    process (clk)
    begin
    	if (rising_edge(clk)) then
    		if(carga = '1') then
				Y <= X;
			end if;
    	end if;
    end process;
end arch_registrador;
