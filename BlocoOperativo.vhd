LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity BlocoOperativo is
	port(
		clk: in std_logic;
		entA, entB: in std_logic_vector(7 downto 0);
		cargaA, cargaB, cargaP, resetP, resetA, sel:
		in std_logic;
		Az, Bz: out std_logic;
		Pout: out std_logic_vector(15 downto 0)
	);
end BlocoOperativo;

architecture arch_BO of BlocoOperativo is
signal selInit: std_logic;
signal saidaRegA, saidaMuxA, saidaRegB, saidaMuxSelB1: std_logic_vector(7 downto 0);
signal saidaRegACONCAT, saidaMuxP, saidaRegP, saidaMuxSelPA, outSumSub: std_logic_vector(15 downto 0);
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


	regP: registrador generic map (16) port map (saidaMuxP, cargaP, clk, saidaRegP);
	regA: registrador generic map (8) port map (saidaMuxA, cargaA, clk, saidaRegA);
	regB: registrador generic map (8) port map (entB, cargaB, clk, saidaRegB);
	muxParaP: mux2para1 generic map (16) port map (outSumSub, sixteenZeros, resetP, saidaMuxP);
	muxParaA: mux2para1 generic map (8) port map (outSumSub(7 downto 0), entA, resetA, saidaMuxA);
	muxPandA: mux2para1 generic map (16) port map (saidaRegP, saidaRegACONCAT, sel, saidaMuxSelPA);
	muxBand1: mux2para1 generic map (8) port map (saidaRegB, eightOnes, sel, saidaMuxSelB1);
	checkAZero: IgualZero generic map (8) port map (saidaRegA, Az);
	checkBZero: IgualZero generic map (8) port map (saidaRegB, Bz);
	SumSub: SomadorSubtrator generic map (16) port map (saidaMuxSelPA, "00000000" & saidaMuxSelB1, sel, outSumSub);
end arch_BO;
