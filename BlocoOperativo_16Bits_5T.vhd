LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity BlocoOperativo_16Bits_5T is
	port(
		clk: in std_logic;
		entA, entB: in std_logic_vector(7 downto 0);
		cargaA, cargaB, cargaP, resetP, resetA:
		in std_logic;
		Az, Bz: out std_logic;
		Pout: out std_logic_vector(15 downto 0)
	);
end BlocoOperativo_16Bits_5T;

architecture arch_BO of BlocoOperativo_16Bits_5T is
signal selInit: std_logic;
signal saidaRegA, saidaMuxA, saidaRegB, saidaMuxSelB1: std_logic_vector(7 downto 0);
signal saidaRegACONCAT, saidaMuxP, saidaRegP, saidaMuxSelPA, outSum, outSub: std_logic_vector(15 downto 0);
signal sixteenZeros: std_logic_vector(15 downto 0) := "0000000000000000";
signal eightOnes: std_logic_vector(7 downto 0) := "11111111";
	component registrador is 
	generic(N : integer := 8);
		port(
			X : in std_logic_vector(N-1 downto 0);
			carga: in std_logic;
			clk : in std_logic;
			Y : out std_logic_vector(N-1 downto 0)
		);
	end component;
	component mux2para1 is
	generic(N : integer := 8);
		port (
			A, B: in std_logic_vector(N-1 downto 0);
			sel: in std_logic;	
			S: out std_logic_vector(N-1 downto 0)
		);
	end component;
	component IgualZero is
	generic(N : integer := 8);
		port (
			X : in std_logic_vector(N-1 downto 0);
			S: out std_logic
		);
	end component;
	component SomadorSubtrator is
	generic(N : integer := 8);
		port(
			A, B: in std_logic_vector(N-1 downto 0);
			sel: in std_logic;
			S: out std_logic_vector(N-1 downto 0)
		);
	end component;
begin 
	--sixteenZeros <= "0000000000000000";
	--eightOnes <= "11111111";
	saidaRegACONCAT <= "00000000" & saidaRegA; -- Para gerar saida de 16 bits


	regP: registrador generic map (32) port map (saidaMuxP, cargaP, clk, saidaRegP);
	regA: registrador generic map (16) port map (saidaMuxA, cargaA, clk, saidaRegA);
	regB: registrador generic map (16) port map (entB, cargaB, clk, saidaRegB);
	muxParaP: mux2para1 generic map (32) port map (outSum, sixteenZeros, resetP, saidaMuxP);
	muxParaA: mux2para1 generic map (16) port map (outSub, entA, resetA, saidaMuxA);
	checkAZero: IgualZero generic map (16) port map (saidaRegA, Az);
	checkBZero: IgualZero generic map (16) port map (saidaRegB, Bz);
	--SumSub: SomadorSubtrator generic map (16) port map (saidaMuxSelPA, "00000000" & saidaMuxSelB1, sel, outSumSub);
	Sum: SomadorSubtrator generic map(32) port map (saidaRegP, "00000000" & saidaRegB, '0', outSum);
	Sub: SomadorSubtrator generic map(16) port map (saidaRegA, "0000000000000001", '1', outSub);
	
end arch_BO;
