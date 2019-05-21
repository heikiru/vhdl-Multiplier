LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Topo_5T_ver2 is
	port(
	inicio, resetFSM: in std_logic;
	entA, entB: in std_logic_vector(15 downto 0);
	clk: in std_logic;
	Pout: out std_logic_vector(31 downto 0)
	);
end Topo_5T_ver2;

architecture arch_Topo of Topo_5T_ver2 is
signal pronto, cargaA, cargaB, cargaP, muxSel, resetP, resetA, Az, Bz: std_logic;
component is
  port (
		
  );
end component;

component is
	port(
	);
end component;

begin
	
	BC: BlocoControle port map(clk, pronto, cargaA, cargaB, cargaP, resetP, resetA, muxSel, inicio, resetFSM, Az, Bz);
	
	BO: BlocoOperativo_16Bits port map(clk, entA, entB, cargaA, cargaB, cargaP, resetP, resetA, muxSel, Az, Bz, Pout);
	
end arch_Topo;
