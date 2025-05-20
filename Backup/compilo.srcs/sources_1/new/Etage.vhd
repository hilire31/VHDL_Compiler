----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2025 05:11:48 PM
-- Design Name: 
-- Module Name: Etage - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Etage is
    Port ( A_in : in STD_LOGIC_VECTOR(7 downto 0);
           OP_in : in STD_LOGIC_VECTOR(7 downto 0);
           B_in : in STD_LOGIC_VECTOR(7 downto 0);
           C_in : in STD_LOGIC_VECTOR(7 downto 0);
           
           A_out : out STD_LOGIC_VECTOR(7 downto 0);
           OP_out : out STD_LOGIC_VECTOR(7 downto 0);
           B_out : out STD_LOGIC_VECTOR(7 downto 0);
           C_out : out STD_LOGIC_VECTOR(7 downto 0);
           
           CLK : in STD_LOGIC);
end Etage;

architecture Behavioral of Etage is

begin

-- Process clock synchro 
    process

    begin

        wait until CLK'event and CLK='1';
        
        A_out <= A_in;
        OP_out <= OP_in;
        B_out <= B_in;
        C_out <= C_in;
        
    
    end process;


end Behavioral;
