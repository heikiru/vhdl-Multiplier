LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_vector;
entity BlocoOperativo_Update is
	port(
		clk, entA, entB: in std_logic;
		cargaA, cargaB, cargaP, resetP, sel:
		in std_logic;
		Az, Bz, Pout: out std_logic
	);
end BlocoOperativo_Update;

architecture arch_BO of BlocoOperativo_Update is
signal saidaMuxP, saidaMuxA, saidaMuxSelPA, saidaMuxSelB1,
saidaRegP, saidaRegA, saidaRegB, selInit, outSumSub: std_logic;

sixteenZeros <= conv_std_logic_vector(0,16);
eightOnes <= conv_std_logic_vector(1, 8);
saidaRegACONCAT <= "00000000" & saidaRegA; -- Para gerar saida de 16 bits

	component registrador is 
		port(
			X : in std_logic_vector(N-1 downto 0);
			carga: in std_logic;
			clk : in std_logic;
			Y : out std_logic_vector(N-1 downto 0)
		);
	end component;
	component mux2para1 is
		port (
			A, B: in std_logic_vector(N-1 downto 0);
			sel: in std_logic;	
			S: out std_logic_vector(N-1 downto 0)
		);
	end component;
	component IgualZero is
		port (
			X : in std_logic_vector(N-1 downto 0);
			S: out std_logic
		);
	end component;
	component SomadorSubtrator is
		port(
			A, B: in std_logic_vector(N-1 downto 0);
			sel: in std_logic;
			S: out std_logic_vector(N-1 downto 0)
		);
	end component;
begin 
	regP: registrador generic map (N <= 16) port map (saidaMuxP, cargaP, clk, saidaRegP);
	regA: registrador generic map (N <= 8) port map (saidaMuxA, cargaA, clk, saidaRegA);
	regB: registrador generic map (N <= 8) port map (entB, cargaB, clk, saidaRegB);
	muxParaP: mux2para1 generic map (N <= 16) port map (outSumSub, sixteenZeros, selInit, saidaMuxP);
	muxParaA: mux2para1 generic map (N <= 8) port map (outSumSub, entA, selInit, saidaMuxA);
	muxPandA: mux2para1 generic map (N <= 16) port map (saidaRegP, saidaRegACONCAT, sel, saidaMuxSelPA);
	muxBand1: mux2para1 generic map (N <= 8) port map (saidaRegB, eightOnes, sel, saidaMuxSelB1);
	checkAZero: IgualZero generic map (N <= 8) port map (saidaRegA, Az);
	checkBZero: IgualZero generic map (N <= 8) port map (saidaRegB, Bz);
	SumSub: SomadorSubtrator generic map (N <= 16) port map (saidaMuxSelPA, saidaMuxSelB1, sel, outSumSub);
	end;
end arch_BO;
