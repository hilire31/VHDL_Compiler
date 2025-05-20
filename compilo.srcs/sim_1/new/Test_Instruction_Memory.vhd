----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2025 08:51:56 AM
-- Design Name: 
-- Module Name: Test_Instruction_Memory - Behavioral
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

entity Test_Instruction_Memory is

end Test_Instruction_Memory;

architecture Behavioral of Test_Instruction_Memory is
-- Component Instruction_Memory
    COMPONENT Instruction_Memory
    Port ( Address : in STD_LOGIC_VECTOR(7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR(31 downto 0);
           EN : in std_logic);
    end COMPONENT;
    
    signal Sig_CLK : STD_LOGIC := '0'; 
    signal Sig_Address : STD_LOGIC_VECTOR(7 downto 0) := "000000001";
    signal Sig_OUTPUT : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal Sig_EN : std_logic := '1';
    
    constant Clock_period : time := 20 ns; 
begin

    Label_uut: Instruction_Memory Port Map ( 
           Address => Sig_Address,
           CLK => Sig_CLK,
           OUTPUT => Sig_OUTPUT,
           EN => Sig_EN); 
           
    -- Clock process definitions
    Clock_process : process
    
    begin 
        Sig_CLK <= not(Sig_CLK);
        wait for Clock_period/2;
    end process;
    Sig_Address <= "000000010" after 10ns, "000000011" after 20ns;

end Behavioral;
