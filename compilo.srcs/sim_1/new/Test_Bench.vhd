----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 10:46:28 AM
-- Design Name: 
-- Module Name: Test_Bench - Behavioral
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

entity Test_Bench is
--  Port ( );
end Test_Bench;

architecture Behavioral of Test_Bench is

    -- Component Bench
    COMPONENT Bench
    Port ( Aad : in STD_LOGIC_VECTOR(3 downto 0);
           Bad : in STD_LOGIC_VECTOR(3 downto 0);
           Wad : in STD_LOGIC_VECTOR(3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR(7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR(7 downto 0);
           QB : out STD_LOGIC_VECTOR(7 downto 0));
    end COMPONENT;
    
    -- Inputs
    signal Sig_Aad : STD_LOGIC_VECTOR(3 downto 0);
    signal Sig_Bad : STD_LOGIC_VECTOR(3 downto 0);
    signal Sig_Wad : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    
    signal Sig_W : STD_LOGIC := '0';
    signal Sig_DATA : STD_LOGIC_VECTOR(7 downto 0);
    
    signal Sig_RST : STD_LOGIC := '1';
    signal Sig_CLK : STD_LOGIC := '0'; 
    
    -- Outputs 
    signal Sig_QA : STD_LOGIC_VECTOR(7 downto 0);
    signal Sig_QB : STD_LOGIC_VECTOR(7 downto 0);
    
    -- Clock period definition
    constant Clock_period : time := 20 ns; 
    
begin

    Label_uut: Bench Port Map ( 
           Aad => Sig_Aad,
           Bad => Sig_Bad,
           Wad => Sig_Wad,
           
           W => Sig_W,
           DATA => Sig_DATA,
           
           RST => Sig_RST,
           CLK => Sig_CLK,
           
           QA => Sig_QA,
           QB => Sig_QB );    


    -- Clock process definitions
    Clock_process : process
    
    begin 
        Sig_CLK <= not(Sig_CLK);
        wait for Clock_period/2;
    end process;
    
    Sig_RST <= '0' after 10ns, '1' after 20ns;
    
    -- regarder registre 2 puis registre 3
    Sig_Aad <= "0010" after 60ns, "0011" after 120ns;
    Sig_Bad <= "0101" after 60ns, "0010" after 120ns;
    
    Sig_Wad <= "0010" after 120ns;
    Sig_W <= '1' after 120ns, '0' after 130ns;
    Sig_DATA <= "00001111" after 100 ns; 
    
    
end Behavioral;
