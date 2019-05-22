LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Topo_5T_ver2 IS -- 16 bits version!
	PORT (
	inicio, resetFSM: in std_logic;
	entA, entB: in std_logic_vector(15 downto 0);
	clk: in std_logic;
	Pout: out std_logic_vector(31 downto 0)
	);
END Topo_5T_ver2;

ARCHITECTURE arch_Topo of Topo_5T_ver2 IS
SIGNAL pronto, cargaA, cargaB, cargaP, muxSel, resetP, resetA, Az, Bz: std_logic;
COMPONENT BlocoControle_5T_ver2 IS 
  PORT (
    clk, init, resetFSM: in std_logic;
    cargaA, cargaB, cargaP, cargaCont: in std_logic;
    resetP: in std_logic; 
    srRegP, srRegA: in std_logic; 
    Az, Bz, ContZ: in std_logic; 
    A_0: in std_logic; 
    pronto: out std_logic
  );
END COMPONENT;

COMPONENT IS
	PORT (
	
	);
END COMPONENT;

BEGIN
	
	BC: BlocoControle_5T_ver2 PORT MAP( -- );
	
	BO: BlocoOperativo_16Bits PORT MAP(clk, entA, entB, cargaA, cargaB, cargaP, resetP, resetA, muxSel, Az, Bz, Pout);
	
END arch_Topo;
