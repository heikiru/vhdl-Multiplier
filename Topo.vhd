LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Topo is
	port(
	inicio, resetFSM: in std_logic;
	entA, entB: in std_logic_vector(7 downto 0);
	clk: in std_logic;
	Pout: out std_logic_vector(15 downto 0)
	);
end Topo;

architecture arch_Topo of Topo is
signal pronto, cargaA, cargaB, cargaP, muxSel, resetP, resetA, Az, Bz: std_logic;
component BlocoControle is
  port (
		clk: in std_logic;
		pronto: out std_logic;
		cargaA, cargaB, cargaP: out std_logic;
		resetP: out std_logic;
		resetA: out std_logic;
		sel: out std_logic;
		inicio: in std_logic;
		resetFSM: in std_logic;
		Az, Bz: in std_logic
  );
end component;

component BlocoOperativo is
	port (
		clk: in std_logic;
		entA, entB: in std_logic_vector(7 downto 0);
		cargaA, cargaB, cargaP, resetP, resetA, sel:
		in std_logic;
		Az, Bz: out std_logic;
		Pout: out std_logic_vector(15 downto 0)
		);
end component;
begin
	
	BC: BlocoControle port map(clk, pronto, cargaA, cargaB, cargaP, resetP, resetA, muxSel, inicio, resetFSM, Az, Bz);
	
	BO: BlocoOperativo port map(clk, entA, entB, cargaA, cargaB, cargaP, resetP, resetA, muxSel, Az, Bz, Pout);
	
end arch_Topo;
