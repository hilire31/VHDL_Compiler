----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 12:03:50 PM
-- Design Name: 
-- Module Name: Instruction_Memory - Behavioral
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

entity Instruction_Memory is
    Port ( Address : in STD_LOGIC_VECTOR(7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR(31 downto 0);
           EN : in std_logic);
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is

    type instruction_array_type is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0); 
    signal instruction_array : instruction_array_type := (others => x"03C10102");
    signal sig_out : STD_LOGIC_VECTOR(31 downto 0);
begin

    -- Process clock synchro 
    process

    begin
    
        wait until CLK'event and CLK='1';
        
        if EN = '1' then
            -- Lecture : 
                -- prendre la valeur à l'adresse Address
            sig_out <= instruction_array(TO_INTEGER(unsigned(Address)));
        end if;

            
    end process;

    OUTPUT <= sig_out;
    
end Behavioral;
