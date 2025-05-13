----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2025 03:33:24 PM
-- Design Name: 
-- Module Name: IP - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IP is
    Port ( CLK : in STD_LOGIC;
           Address : out STD_LOGIC_VECTOR(7 downto 0));
end IP;

architecture Behavioral of IP is

signal OUTPUT : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

begin

    -- Process clock synchro 
    process

    begin
    
        wait until CLK'event and CLK='1';
        
        OUTPUT <= std_logic_vector(unsigned(OUTPUT) + 1);

    end process;

    Address <= OUTPUT;

end Behavioral;
