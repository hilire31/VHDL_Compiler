----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/20/2025 03:58:15 PM
-- Design Name: 
-- Module Name: Aleas_Manager - Behavioral
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

entity Aleas_Manager is
    Port ( Next_Instruction_B_address : in STD_LOGIC_VECTOR(3 downto 0);
           Next_Instruction_C_address : in STD_LOGIC_VECTOR(3 downto 0);
           Next_Instruction_OP : in STD_LOGIC_VECTOR(3 downto 0);
           
           Current_Instruction_A_address : in STD_LOGIC_VECTOR(3 downto 0);
           
           Enable_IP_InstructionMemory : out STD_LOGIC;
           CLK : in STD_logic);
end Aleas_Manager;

architecture Behavioral of Aleas_Manager is
    
    signal AFC_OP : STD_LOGIC_VECTOR(3 downto 0) := "1010"; 
    signal COP_OP : STD_LOGIC_VECTOR(3 downto 0) := "1110";
    signal LOAD_OP : STD_LOGIC_VECTOR(3 downto 0) := "1101";
    signal STORE_OP : STD_LOGIC_VECTOR(3 downto 0) := "0101";
    
    signal ADD_OP : STD_LOGIC_VECTOR(3 downto 0) := "0001";
    signal SUB_OP : STD_LOGIC_VECTOR(3 downto 0) := "0011";
    signal MUL_OP : STD_LOGIC_VECTOR(3 downto 0) := "0010";
    signal DIV_OP : STD_LOGIC_VECTOR(3 downto 0) := "0100";
    signal XOR_OP : STD_LOGIC_VECTOR(3 downto 0) := "1000";
    signal AND_OP : STD_LOGIC_VECTOR(3 downto 0) := "1001";
    signal OR_OP : STD_LOGIC_VECTOR(3 downto 0) := "1100";
    signal NOTA_OP : STD_LOGIC_VECTOR(3 downto 0) := "1011";
    signal NOTB_OP : STD_LOGIC_VECTOR(3 downto 0) := "1111";
    
    signal NOP_OP : std_logic_vector(3 downto 0) := "0110";
    
    signal enable : std_logic := '1';
    
begin

    process

    begin
    
        wait until CLK'event and CLK='1';
        
        enable <= '1';
        
        -- ALEAS OP /= (NOP, LOAD, AFC) and 
        if (Next_Instruction_OP /= NOP_OP and Next_Instruction_OP /= LOAD_OP and Next_Instruction_OP /= AFC_OP) then
            -- A address = B or C address
            if (Current_Instruction_A_address = Next_Instruction_B_address or 
                Current_Instruction_A_address = Next_Instruction_C_address) then
                enable <= '0';
            end if;
        
        end if;
    
    end process;
    
    Enable_IP_InstructionMemory <= enable;


end Behavioral;
