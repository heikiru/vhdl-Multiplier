    
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY BlocoControle_5T_ver2 IS
  PORT (
    clk, init, resetFSM: in std_logic;
    cargaA, cargaB, cargaP, cargaCont: out std_logic;
    muxP, muxCont, muxSum: out std_logic;
    srRegP, srRegA: out std_logic; -- Shift Right inputs to P and A
    Az, Bz, ContZ: in std_logic; -- verifies if A, B and Cont are zero in certain situations
    A_0: in std_logic; -- Verifies if the bit zero in A is equal to one or not
    pronto: out std_logic
  );
    
    -- Still needs to get the first 8 bits from register P. 
    -- In this case, we are treating P like only one register, although the layout of the project asked for two.
  
END BlocoControle_5T_ver2;

ARCHITECTURE arch_BC_5T_ver2 IS
TYPE state IS (S0, S1, S2, S3, S4, S5, S6);
SIGNAL EA, PE: state;

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
          muxP <= '1';
          muxCont <= '1';
          muxSum <= '1';
          PE <= S2;
        WHEN S2 =>
            cargaA <= '0';
            cargaB <= '0';
            cargaCont <= '0';
            muxP <= '0';
            muxCont <= '0';
            muxSum <= '1';
            IF Az = '1' OR Bz = '1' THEN
              PE <= S6;
            ELSE 
              PE <= S3;
            END IF;
        WHEN S3 =>
            IF ContZ = '1' THEN
              PE <= S6;
            ELSE 
              IF A_0 = '1' THEN
                PE <= S4;
              ELSE
                PE <= S5;
              END IF;
            END IF;
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
        END CASE;
    ELSE
        PE <= S0;
    END IF;
  END PROCESS;
        
END arch_BC_5T_ver2;
