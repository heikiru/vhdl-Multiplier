LIBRARY ieee;
USE ieee.std_logic_1164.all; -- STILL NEEDS THE REGISTER_SHIFT FROM A LATER MERGE

ENTITY BlocoOperativo_5T_ver2_8bits IS
  GENERIC(N: INTEGER: 8);
  PORT(
      clk: in std_logic;
      entA, entB: in std_logic_vector(N-1 downto 0);
      cargaA, cargaB, cargaP, cargaCont: in std_logic;
      sel: in std_logic;
      srRegP, srRegA: in std_logic;
      Az, Bz, ContZ: out std_logic;
      A_0: out std_logic
  );
END ENTITY;

ARCHITECTURE arch_BO_5T_ver2 OF BlocoOperativo_5T_ver2 IS
SIGNAL saidaP, saidaA, saidaB, saidaCont: std_logic_vector(N-1 downto 0);
SIGNAL saidaSum, saidaSub: std_logic_vector(N-1 downto 0);
SIGNAL saidaMuxP, saidaMuxSum, saidaMuxCont: std_logic_vector(N-1 downto 0);
SIGNAL shiftP, shiftA: std_logic;
SIGNAL leastSigP, leastSigA, mostSigA: std_logic;
SIGNAL cOut: std_logic;
  
  COMPONENT IgualZero IS
    PORT (
      X : in std_logic_vector(N-1 downto 0);
      S: out std_logic
    );
  END COMPONENT;
  
  COMPONENT Mux2para1 IS 
    PORT (
      A, B: in std_logic_vector(N-1 downto 0);
		  sel: in std_logic;	
		  S: out std_logic_vector(N-1 downto 0)
    );
  END COMPONENT;
  
  COMPONENT registrador IS
    PORT (
      X : in std_logic_vector(N-1 downto 0);
      carga: in std_logic;
      clk : in std_logic;
      Y : out std_logic_vector(N-1 downto 0)
    );
  END COMPONENT;
  
  COMPONENT registrador_com_shift IS 
  PORT (
      X : in std_logic_vector(N-1 downto 0);
      b: in std_logic;
      shift, carga: in std_logic;
      clk : in std_logic;
      o: out std_logic;
      Y : out std_logic_vector(N-1 downto 0)
  );
  
  COMPONENT SomadorSubtrator IS
    PORT (
      A, B: in std_logic_vector(N-1 downto 0);
		  sel: in std_logic;
		  S: out std_logic_vector(N-1 downto 0)
    );
  END COMPONENT;
BEGIN
  
  flipflop: registrador generic map(1) port map(saidaMuxSub, '1', clk, saidaMuxSub);
  regP: registrador_com_shift generic map(8) port map(saidaMuxP, saidaMuxSub, srRegP, cargaP, clk, leastSigP, saidaP);
  regA: registrador_com_shift generic map(8) port map(entA, mostSigA, srRegA, cargaA, clk, leastSigA, saidaA);
  regB: registrador generic map(8) port map(entB, cargaB, clk, saidaB);
  regCont: registrador generic map(4) port map(saidaMuxCont, cargaCont, clk, saidaCont);
  MuxP: mux2para1 generic map(8) port map(saidaSum, "00000000", sel, saidaMuxP);
  MuxCont: mux2para1 generic map(4) port map(saidaSub, "0000", sel, saidaMuxCont);
  MuxSub: mux2para1 generic map(1) port map(cOut, '0', sel, saidaMuxSum);
  Sum: SumSub generic map(8) port map(saidaP, saidaB, '0', saidaSum);
  Sub: SumSub generic map(4) port map(saidaCont, "1111", '1', saidaSub);
  aZero: IgualZero generic map(8) port map(saidaA, Az);
` bZero: IgualZero generic map(8) port map(saidaB, Bz);
  contZero: IgualZero generic map(4) port map(saidaP, ContZ);
  A_0 <= saidaA(0);

END arch_BO_5T_ver2;
