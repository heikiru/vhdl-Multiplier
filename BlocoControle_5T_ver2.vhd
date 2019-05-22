    
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY BlocoControle_5T_ver2 IS
  PORT (
    clk, init, resetFSM: in std_logic;
    cargaA, cargaB, cargaP, cargaCont: in std_logic;
    resetA, resetB, resetP, resetCont: in std_logic; -- resetP can be taken later, since we are using a Mux
    srRegP, srRegA: in std_logic; -- Shift Right inputs to P and A
    Az, Bz, ContZ: in std_logic; -- verifies if A, B and Cont are zero in certain situations
    pronto: out std_logic
  );
    
    -- Still needs to get the first 8 bits from register P. 
    -- In this case, we are treating P like only one register, although the layout of the project asked for two.
  
END BlocoControle_5T_ver2;

ARCHITECTURE arch_BC_5T_ver2 IS
TYPE state IS (S0, S1, S2, S3, S4, S5, S6);
SIGNAL EA, PE: state;
SIGNAL A_0: std_logic;

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
          PE <= S2;
        WHEN S2 =>
            cargaA <= '0';
            cargaB <= '0';
            cargaCont <= '0';
            resetP <= '0';
            IF Az = '1' OR Bz = '1' THEN
              PE <= S6;
            ELSE 
              PE <= S3;
        WHEN S3 =>
            IF ContZ = '1' THEN
              PE <= S6;
            ELSE 
              IF A_0 = '1' THEN
                PE <= S4;
              ELSE
                PE <= S5;
        WHEN S4 =>
            cargaP <= '1';
            PE <= S5;
        WHEN S5 =>
            cargaP <= '0';
            srRegP <= '1';
            srRegA <= '1';
            CargaCont <= '1';
            PE <= S3;
        WHEN S6 =>
            pronto <= '1';
            PE <= S0;
