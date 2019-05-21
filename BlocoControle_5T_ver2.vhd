    
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY BlocoControle_5T_ver2 IS
  port (
    clk, init, resetFSM: in std_logic;
    cargaA, cargaB, cargaP, cargaCont: in std_logic;
    resetA, resetB, resetP, resetCont: in std_logic;
    Az, Bz: in std_logic;
    pronto: out std_logic;
  );
  
end BlocoControle_5T_ver2;

ARCHITECTURE arch_BC_5T_ver2 IS
TYPE state IS (S0, S1, S2, S3, S4, S5, S6);
STATE EA, PE: state;

BEGIN
  PROCESS(clk, EA)
  BEGIN
    IF rising_edge(clk) THEN
      EA <= PE;
    END IF;
    
    IF resetFSM = '0' THEN
      CASE EA IS
        WHEN S0 =>
          IF init = '0' THEN
            PE <= S0;
          ELSE 
            PE <= S1;
          END IF;
        WHEN S1 =>
          pronto <= '0';
          cargaA <= '1';
          cargaB <= '1';
          cargaCont <= '1';
          resetP <= '1';
        WHEN S2 =>
          IF A
        WHEN S3 =>
        WHEN S4 =>
        WHEN S5 =>
        WHEN S6 =>
    
-- Still to finish
