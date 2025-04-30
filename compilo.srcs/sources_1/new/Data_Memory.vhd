----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 12:08:20 PM
-- Design Name: 
-- Module Name: Data_Memory - Behavioral
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


entity Data_Memory is
    Port ( Address : in STD_LOGIC_VECTOR(7 downto 0);
           INPUT : in STD_LOGIC_VECTOR(7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR(7 downto 0));
end Data_Memory;

architecture Behavioral of Data_Memory is

type data_array_type is array (0 to 63) of STD_LOGIC_VECTOR(7 downto 0); 
signal data_array : data_array_type := (others => (others => '0'));
signal sig_out : STD_LOGIC_VECTOR(7 downto 0);
begin
    -- Process clock synchro 
    process

    begin
    
        wait until CLK'event and CLK='1';
        if RST='0' then -- RESET : mettre tous les registres à zéro
            -- HORRIBLE SYNTAX           
            data_array <= (others => (others => '0'));
        elsif RW='0' then -- ECRITURE : 
            -- prendre la valeur dans INPUT et 
            -- le stocker à l'adresse Address
            data_array(TO_INTEGER(unsigned(Address))) <= INPUT;
        elsif RW='1' then -- Lecture : 
            -- prendre la valeur à l'adresse Address
             sig_out <= data_array(TO_INTEGER(unsigned(Address)));
                     
        end if;
            
    end process;
OUTPUT <= sig_out;

end Behavioral;
