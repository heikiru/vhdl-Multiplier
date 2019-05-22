LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity BlocoControle_5T is
	port(
		clk: in std_logic;
		pronto: out std_logic;
		cargaA, cargaB, cargaP: out std_logic;
		resetP: out std_logic;
		resetA: out std_logic;
		inicio: in std_logic;
		resetFSM: in std_logic;
		Az, Bz: in std_logic
	);
end BlocoControle_5T;

architecture arch_BO of BlocoControle_5T is
TYPE state is(S0, S1, S2, S3, S5);
SIGNAL EA, PE: state;
begin
	
	process(EA, clk) 
	begin
		if rising_edge(clk) then
			EA <= PE;
		end if;
		
		if resetFSM = '0' then
			case EA is
			when S0 =>
				if inicio = '1' then
					PE <= S1;
				else 
					PE <= S0;
				end if;
			when S1 =>
					pronto <= '0';
					cargaA <= '1';
					cargaB <= '1';
					resetP <= '1';
					resetA <= '1';
					PE <= S2;
			when S2 =>
					pronto <= '0';
					cargaA <= '0';
					cargaB <= '0';
					resetA <= '0';
					resetP <= '0';
				if Az = '0' and Bz = '0' then
					PE <= S3;
				else
					PE <= S5;
				end if;
			when S3 =>
				cargaP <= '1';
				cargaA <= '1';
				PE <= S2;
			when S5 =>
				pronto <= '1';
				PE <= S0;
			end case;
		else
			PE <= S0;
		end if;
	end process;
	
end arch_BO;
