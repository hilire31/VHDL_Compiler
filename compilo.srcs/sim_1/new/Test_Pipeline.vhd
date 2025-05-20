----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2025 03:24:33 PM
-- Design Name: 
-- Module Name: Test_Pipeline - Behavioral
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

entity Test_Pipeline is
--  Port ( );
end Test_Pipeline;

architecture Behavioral of Test_Pipeline is

    COMPONENT Pipeline 
        Port(
         sig_clk : in STD_LOGIC
        );
    END COMPONENT; 
        
    constant Clock_period : time := 20 ns;
    signal sig_clk : std_logic := '0';
begin
    
   proc : Pipeline port map ( sig_clk => sig_clk);

-- Clock process definitions
    Clock_process : process
    
    begin 
        Sig_CLK <= not(Sig_CLK);
        wait for Clock_period/2;
    end process;


end Behavioral;
