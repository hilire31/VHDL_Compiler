----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2025 08:49:58 AM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity ALU is
    Port (
           A : in  STD_LOGIC_VECTOR(7 downto 0); -- 1er chiffre sur 8 bits
           B : in STD_LOGIC_VECTOR(7 downto 0); -- 2e chiffre sur 8 bits
           S : out STD_LOGIC_VECTOR(7 downto 0); -- résultat en sortie
           
           N : out STD_LOGIC; -- Negative
           O : out STD_LOGIC; -- Overflow
           Z : out STD_LOGIC; -- Zero, sortie nulle
           C : out STD_LOGIC; -- Carry, la retenue
           
           Ctrl_Alu : in STD_LOGIC_VECTOR(2 downto 0)); -- Informe l'opération à faire (ADD, SUB, MUL, DIV)
end ALU;

architecture Behavioral of ALU is
    signal Result_Operation : STD_LOGIC_VECTOR(15 downto 0);
    signal Carry : STD_LOGIC_VECTOR(8 downto 0);
begin
    
    process (A, B, Ctrl_Alu)
    
    begin
    
    case(Ctrl_Alu) is
    when "0001" =>  -- Add
        Result_Operation <= std_logic_vector(unsigned(X"00" & A) + unsigned(X"00" & B));
        
    when "0011" =>  -- Sub
        Result_Operation <= std_logic_vector(unsigned(X"00" & A) - unsigned(X"00" & B));
        
    when "0010" =>  -- Mul
        Result_Operation <= std_logic_vector(unsigned(A) * unsigned(B));
        
    --when "110" =>  -- Div TOOOOO DOOOOOO AGAINNN
      --  Result_Operation <= std_logic_vector(unsigned(A) / unsigned(B));
        
    when "1000" =>  -- XOR
        Result_Operation <= std_logic_vector(unsigned(X"00" & A) xor unsigned(X"00" & B));
        
    when "1001" =>  -- AND
        Result_Operation <= std_logic_vector(unsigned(X"00" & A) and unsigned(X"00" & B));
        
    when "1100" =>  -- OR
        Result_Operation <= std_logic_vector(unsigned(X"00" & A) or unsigned(X"00" & B));
        
    when "1011" =>  -- NOT A
        Result_Operation <= std_logic_vector(not unsigned(X"00" & A));
        
    when "1111" =>  -- NOT B
        Result_Operation <= std_logic_vector(not unsigned(X"00" & B));
        
    when others =>  -- Add
        Result_Operation <= std_logic_vector(unsigned(X"00" & A) + unsigned(X"00" & B));
    end case;
    
    end process;
    
    S <= Result_Operation(7 downto 0);
    
    Z <= '1' when (Result_Operation = "0")  else '0';
    C <= Result_Operation(8) when (Ctrl_Alu="001") else '0';
    O <= '1' when (Result_Operation > "11111111")  else '0';
    N <= '1' when (Result_Operation < "0")  else '0';

end Behavioral;
