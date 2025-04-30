----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 09:41:30 AM
-- Design Name: 
-- Module Name: Bench - Behavioral
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

entity Bench is
    Port ( Aad : in STD_LOGIC_VECTOR(3 downto 0);
           Bad : in STD_LOGIC_VECTOR(3 downto 0);
           Wad : in STD_LOGIC_VECTOR(3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR(7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR(7 downto 0);
           QB : out STD_LOGIC_VECTOR(7 downto 0));
end Bench;

architecture Behavioral of Bench is

signal sigQA : STD_LOGIC_VECTOR(7 downto 0);
signal sigQB : STD_LOGIC_VECTOR(7 downto 0);

type register_array_type is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0); 
signal registerArray : register_array_type := (others => (others => '0'));

begin

    
    -- Process clock synchro 
    process

    begin
    
        wait until CLK'event and CLK='1';

        if RST='0' then -- RESET : mettre tous les registres à zéro
            -- HORRIBLE SYNTAX           
            registerArray <= (others => (others => '0'));
            
        elsif W='1' then -- ECRITURE : 
            -- prendre la valeur dans DATA et 
            -- le stocker dans le registre qui est à l'adresse Wadd
            registerArray(TO_INTEGER(unsigned(Wad))) <= DATA;
            
                     
        end if;
            
    end process;
    
    -- lecture 
    -- Ajout du fait que s'il y a une lecture et une écriture simultanée sur le même registre
    -- Solution : lire DATA sinon lire le registre (seul cas quqnd on ecrit et que les addresses sont les mêmes)
    
    QA <= DATA when Wad = Aad and W ='1' else registerArray(TO_INTEGER(unsigned(Aad)));
    QB <= DATA when Wad = Bad and W ='1' else registerArray(TO_INTEGER(unsigned(Bad)));
   


end Behavioral;









