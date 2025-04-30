----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2025 10:21:31 AM
-- Design Name: 
-- Module Name: Test_ALU - Behavioral
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

entity Test_ALU is
--  Port ( );
end Test_ALU;
architecture Behavioral of Test_ALU is
    COMPONENT Compteur_8bits
        Port ( CLK : in STD_LOGIC;
               SENS : in STD_LOGIC;
               RST : in STD_LOGIC;
               LOAD : in STD_LOGIC;
               EN : in STD_LOGIC;
    
               Din : in std_logic_vector(7 downto 0);
               Dout : out std_logic_vector(7 downto 0));
        end COMPONENT;
begin


end Behavioral;
