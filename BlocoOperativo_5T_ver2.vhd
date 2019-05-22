LIBRARY ieee;
USE ieee.std_logic_1164.all; -- STILL NEEDS THE REGISTER_SHIFT FROM A LATER MERGE

ENTITY BlocoOperativo_5T_ver2_8bits IS
  PORT(
    clk: in std_logic;
    entA, entB: in std_logic_vector(7 downto 0);
    cargaA, cargaB, cargaP, cargaCont: in std_logic;
    resetP: in std_logic;
    sel: in std_logic;
    srRegP, srRegA: in std_logic;
    Az, Bz, ContZ: out std_logic;
    A_0: out std_logic;
  );
END ENTITY;

ARCHITECTURE arch_BO_5T_ver2 OF BlocoOperativo_5T_ver2 IS

END arch_BO_5T_ver2;

-- We will be using 2 Muxes, 2 Shift_right Registers, 2 common registers,
-- 1 sum, 1 sub and 3 checkIfZero blocks.
