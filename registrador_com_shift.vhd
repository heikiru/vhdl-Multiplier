LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity registrador_com_shift is
	generic(N : integer := 8);
	port(
		X : in std_logic_vector(N-1 downto 0);
		b: in std_logic;
		shift, carga: in std_logic;
		clk : in std_logic;
		o: out std_logic;
		Y : out std_logic_vector(N-1 downto 0)
	);
end registrador_com_shift;

architecture arch_registrador of registrador_com_shift is
begin
    process (clk)
    begin
    	if (rising_edge(clk)) then
    		if(carga = '1') then
				
				if shift = '1' then
					Y <= b & X(N-1 downto 1);
				else Y <= X;
				end if;
			end if;
    	end if;
    end process;
	 
	 o <= X(0);
	 
end arch_registrador;
