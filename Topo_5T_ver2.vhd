LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Topo_5T_ver2 IS -- 16 bits version!
	PORT (
	inicio, resetFSM: in std_logic;
	entA, entB: in std_logic_vector(15 downto 0);
    clk: in std_logic;
    pronto: out std_logic;
	Pout: out std_logic_vector(31 downto 0)
	);
END Topo_5T_ver2;

ARCHITECTURE arch_Topo of Topo_5T_ver2 IS
SIGNAL pronto, cargaA, cargaB, cargaP, muxSel, resetP, resetA, Az, Bz: std_logic;
COMPONENT BlocoControle_5T_ver2 IS 
  PORT (
    clk, init, resetFSM: in std_logic;
    cargaA, cargaB, cargaP, cargaCont: out std_logic;
    muxP, muxCont, muxSum: out std_logic;
    srRegP, srRegA: out std_logic; -- Shift Right inputs to P and A
    Az, Bz, ContZ: in std_logic; -- verifies if A, B and Cont are zero in certain situations
    A_0: in std_logic; -- Verifies if the bit zero in A is equal to one or not
    pronto: out std_logic
  );
END COMPONENT;

COMPONENT BlocoOperativo_5T_16bits IS
	PORT (
        clk: in std_logic;
        entA, entB: in std_logic_vector(N-1 downto 0);
        cargaA, cargaB, cargaP, cargaCont: in std_logic;
        sel: in std_logic;
        srRegP, srRegA: in std_logic;
        Az, Bz, ContZ: out std_logic;
        A_0: out std_logic
	);
END COMPONENT;

BEGIN
	
	BC: BlocoControle_5T_ver2 PORT MAP(clk, init, resetFSM, cargaA, cargaB, cargaP, cargaCont,  muxSel, muxSel, muxSel, srRegP, srRegA, Az, Bz, ContZ, A_0);
	
	BO: BlocoOperativo_5T_16Bits PORT MAP(clk, entA, entB, cargaA, cargaB, cargaP, cargaCont, muxSel, srRegP, srRegA, Az, Bz, ContZ, A_0);
	
END arch_Topo;
