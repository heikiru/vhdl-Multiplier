LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Topo_16Bits_5T is
	port(
	inicio, resetFSM: in std_logic;
	entA, entB: in std_logic_vector(15 downto 0);
	clk: in std_logic;
	Pout: out std_logic_vector(31 downto 0)
	);
end Topo_16Bits_5T;

architecture arch_Topo of Topo_16Bits_5T is
signal pronto, cargaA, cargaB, cargaP, resetP, resetA, Az, Bz: std_logic;
component BlocoControle_5T is
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
end component;

component BlocoOperativo_16Bits_5T is
	port(
		clk: in std_logic;
		entA, entB: in std_logic_vector(15 downto 0);
		cargaA, cargaB, cargaP, resetP, resetA:
		in std_logic;
		Az, Bz: out std_logic;
		Pout: out std_logic_vector(31 downto 0)
	);
end component;

begin
	
	BC: BlocoControle_5T port map(clk, pronto, cargaA, cargaB, cargaP, resetP, resetA, inicio, resetFSM, Az, Bz);
	
	BO: BlocoOperativo_16Bits_5T port map(clk, entA, entB, cargaA, cargaB, cargaP, resetP, resetA, Az, Bz, Pout);
	
end arch_Topo;
