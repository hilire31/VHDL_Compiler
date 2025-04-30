----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2025 08:51:56 AM
-- Design Name: 
-- Module Name: Test_Data_Memory - Behavioral
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

entity Test_Data_Memory is
    
end Test_Data_Memory;

architecture Behavioral of Test_Data_Memory is

    COMPONENT Data_Memory
    Port ( Address : in STD_LOGIC_VECTOR(7 downto 0);
       INPUT : in STD_LOGIC_VECTOR(7 downto 0);
       RW : in STD_LOGIC;
       RST : in STD_LOGIC;
       CLK : in STD_LOGIC;
       OUTPUT : out STD_LOGIC_VECTOR(7 downto 0));
    end COMPONENT;
    
    signal Sig_Address : STD_LOGIC_VECTOR(7 downto 0) := "00000001";
    signal Sig_INPUT : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal Sig_RW : STD_LOGIC := '1'; -- reading at initialization 
    signal Sig_RST : STD_LOGIC := '1';
    signal Sig_CLK : STD_LOGIC := '0'; 
    signal Sig_OUTPUT : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    
    constant Clock_period : time := 20 ns; 
    
begin

    Label_uut: Data_Memory Port Map ( 
           Address => Sig_Address,
           INPUT => Sig_INPUT,
           RW => Sig_RW,
           RST => Sig_RST,
           CLK => Sig_CLK,
           OUTPUT => Sig_OUTPUT); 
           
    -- Clock process definitions
    Clock_process : process
    
    begin 
        Sig_CLK <= not(Sig_CLK);
        wait for Clock_period/2;
    end process;
    
    Sig_RST <= '0' after 10ns, '1' after 20ns;
    Sig_Address <= "00000010" after 30ns, "00000011" after 50ns, "00000010" after 100ns, "00000011" after 150ns;
    Sig_RW <= '0' after 40ns, '1' after 120ns;--lecture en @10 puis écriture en @11 et en @10 puis lecture en @11
    Sig_INPUT <= "00000100" after 40ns,"00011000" after 80ns; --écriture : $4 en @10 puis $24 en @11
    
end Behavioral;
