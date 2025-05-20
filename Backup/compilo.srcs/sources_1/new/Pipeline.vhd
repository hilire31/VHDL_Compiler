----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2025 09:56:18 AM
-- Design Name: 
-- Module Name: Pipeline - Behavioral
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

entity Pipeline is
Port(
 sig_CLK : in STD_LOGIC
);

end Pipeline;

architecture Behavioral of Pipeline is

    COMPONENT Aleas_Manager 
    Port ( Next_Instruction_B_address : in STD_LOGIC_VECTOR(3 downto 0);
           Next_Instruction_C_address : in STD_LOGIC_VECTOR(3 downto 0);
           Next_Instruction_OP : in STD_LOGIC_VECTOR(3 downto 0);
           Current_Instruction_A_address : in STD_LOGIC_VECTOR(3 downto 0);
           Enable_IP_InstructionMemory : out STD_LOGIC;
           CLK : in STD_logic);
     END COMPONENT;

    COMPONENT Etage
    Port ( A_in : in STD_LOGIC_VECTOR(7 downto 0);
           OP_in : in STD_LOGIC_VECTOR(7 downto 0);
           B_in : in STD_LOGIC_VECTOR(7 downto 0);
           C_in : in STD_LOGIC_VECTOR(7 downto 0);
           A_out : out STD_LOGIC_VECTOR(7 downto 0);
           OP_out : out STD_LOGIC_VECTOR(7 downto 0);
           B_out : out STD_LOGIC_VECTOR(7 downto 0);
           C_out : out STD_LOGIC_VECTOR(7 downto 0);
           CLK : in STD_LOGIC);
    END COMPONENT;
    
    COMPONENT IP  
    Port ( CLK : in STD_LOGIC;
           Address : out STD_LOGIC_VECTOR(7 downto 0);
           EN : in std_logic);
    END COMPONENT;
    
    COMPONENT Instruction_Memory 
    Port ( Address : in STD_LOGIC_VECTOR(7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR(31 downto 0);
           EN : in std_logic);
    END COMPONENT;
    
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
    
    COMPONENT ALU 
    Port ( A : in  STD_LOGIC_VECTOR(7 downto 0); 
           B : in STD_LOGIC_VECTOR(7 downto 0); 
           S : out STD_LOGIC_VECTOR(7 downto 0); 
           N : out STD_LOGIC; -- Negative
           O : out STD_LOGIC; -- Overflow
           Z : out STD_LOGIC; -- Zero, sortie nulle
           C : out STD_LOGIC; -- Carry, la retenue
           Ctrl_Alu : in STD_LOGIC_VECTOR(3 downto 0));
     END COMPONENT;
     
     COMPONENT Data_Memory 
     Port (Address : in STD_LOGIC_VECTOR(7 downto 0);
           INPUT : in STD_LOGIC_VECTOR(7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR(7 downto 0);
           EN : in STD_LOGIC);
    END COMPONENT;
    
    
-- LI 
signal A_LI : STD_LOGIC_VECTOR(7 downto 0);
signal OP_LI : STD_LOGIC_VECTOR(7 downto 0);
signal B_LI : STD_LOGIC_VECTOR(7 downto 0);
signal C_LI : STD_LOGIC_VECTOR(7 downto 0);

-- DI 
signal A_DI : STD_LOGIC_VECTOR(7 downto 0);
signal OP_DI : STD_LOGIC_VECTOR(7 downto 0);
signal B_DI : STD_LOGIC_VECTOR(7 downto 0);
signal C_DI : STD_LOGIC_VECTOR(7 downto 0);

-- EX
signal A_EX : STD_LOGIC_VECTOR(7 downto 0);
signal OP_EX : STD_LOGIC_VECTOR(7 downto 0);
signal B_EX : STD_LOGIC_VECTOR(7 downto 0);
signal C_EX : STD_LOGIC_VECTOR(7 downto 0);

-- Mem  
signal A_Mem : STD_LOGIC_VECTOR(7 downto 0);
signal OP_Mem : STD_LOGIC_VECTOR(7 downto 0);
signal B_Mem : STD_LOGIC_VECTOR(7 downto 0);

-- RE 
signal A_RE : STD_LOGIC_VECTOR(7 downto 0); 
signal OP_RE : STD_LOGIC_VECTOR(7 downto 0);
signal B_RE : STD_LOGIC_VECTOR(7 downto 0);

-- clock
signal sig_RST : STD_LOGIC;

-- Signaux "speciaux"

signal sig_enable_IP_and_InstMem : STD_LOGIC := '1';

signal OUT_QA_Bench : STD_LOGIC_VECTOR(7 downto 0);
signal OUT_QB_Bench : STD_LOGIC_VECTOR(7 downto 0);
signal OUT_MUX_B_DI : STD_LOGIC_VECTOR(7 downto 0);

signal OUT_LC_OP_EX : STD_LOGIC_VECTOR(3 downto 0); 
signal OUT_S_ALU : STD_LOGIC_VECTOR(7 downto 0);
signal OUT_MUX_B_EX : STD_LOGIC_VECTOR(7 downto 0);

signal OUT_LC_OP_Mem : STD_LOGIC; 
signal OUT_LC_A_Mem : STD_LOGIC; 
signal OUT_MUX_1_B_Mem : STD_LOGIC_VECTOR(7 downto 0);
signal OUT_MUX_2_B_Mem : STD_LOGIC_VECTOR(7 downto 0);
signal OUT_OUTPUT_DataMem : STD_LOGIC_VECTOR(7 downto 0);

signal OUT_LC_OP_RE : STD_LOGIC; 

signal IN_Address_InstMem : STD_LOGIC_VECTOR(7 downto 0);
signal OUT_Instruction_InstMem : STD_LOGIC_VECTOR(31 downto 0);

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

-- not used :0000 0111 

signal NOP_OP : std_logic_vector(3 downto 0) := "0110";

begin

-- Instruction Pointer (IP) 
    uIp : IP Port Map (
        CLK => Sig_CLK,
        Address => IN_Address_InstMem,
        EN => sig_enable_IP_and_InstMem);

-- Memoire d'instructions (INSTUCTION_MEMORY) 
    uIm : Instruction_Memory Port Map ( 
           Address => IN_Address_InstMem,
           CLK => Sig_CLK,
           OUTPUT => OUT_Instruction_InstMem,
           EN => sig_enable_IP_and_InstMem); 
           
-- LI_DI 
    LI_DI : Etage Port Map(
           A_in => A_LI,
           OP_in => OP_LI,
           B_in => B_LI,
           C_in => C_LI,
           A_out => A_DI,
           OP_out => OP_DI,
           B_out => B_DI,
           C_out => C_DI,
           CLK => Sig_CLK);
           
-- Gestion Aleas (Aleas Manager) with next intruction at LI and current instruction at DI
    uAM_LI_DI : Aleas_Manager Port Map(
           Next_Instruction_B_address => B_LI(3 downto 0),
           Next_Instruction_C_address => C_LI(3 downto 0),
           Next_Instruction_OP => OP_LI(3 downto 0),
           Current_Instruction_A_address => A_DI(3 downto 0),
           Enable_IP_InstructionMemory => sig_enable_IP_and_InstMem,
           CLK => Sig_CLK);

-- Banc de registres (BENCH) 
       uBr : Bench Port Map ( 
                 Aad => B_DI(3 downto 0),
                 Bad => C_DI(3 downto 0),
                 Wad => A_RE(3 downto 0),
                 
                 W => OUT_LC_Op_Mem,
                 DATA => B_RE,
                 
                 RST => Sig_RST,
                 CLK => Sig_CLK,
                 
                 QA => OUT_QA_Bench,
                 QB => OUT_QB_Bench );
           
-- DI_EX 
       DI_EX : Etage Port Map(
                 A_in => A_DI,
                 OP_in => OP_DI,
                 B_in => OUT_MUX_B_DI,
                 C_in => OUT_QB_Bench,
                 A_out => A_EX,
                 OP_out => OP_EX,
                 B_out => B_EX,
                 C_out => C_EX,
                 CLK => Sig_CLK);

-- Gestion Aleas (Aleas Manager) with next intruction at LI and current instruction at EX
    uAM_LI_EX : Aleas_Manager Port Map(
           Next_Instruction_B_address => B_LI(3 downto 0),
           Next_Instruction_C_address => C_LI(3 downto 0),
           Next_Instruction_OP => OP_LI(3 downto 0),
           Current_Instruction_A_address => A_EX(3 downto 0),
           Enable_IP_InstructionMemory => sig_enable_IP_and_InstMem,
           CLK => Sig_CLK);
                 
 -- ALU 
       uAlu : ALU Port Map(
                 A => B_EX,
                 B => C_EX,
                 S => OUT_S_ALU,
                 N => open,
                 O => open,
                 Z => open,
                 C => open,
                 Ctrl_Alu => OUT_LC_OP_EX);
                 
-- EX_Mem 
       EX_MEM : Etage Port Map(
                 A_in => A_EX,
                 OP_in => OP_EX,
                 B_in => OUT_MUX_B_EX,
                 C_in => x"00", -- no input 
                 A_out => A_Mem,
                 OP_out => OP_Mem,
                 B_out => B_Mem,
                 C_out => open, -- no output 
                 CLK => Sig_CLK);
                 
-- Gestion Aleas (Aleas Manager) with next intruction at LI and current instruction at Mem
    uAM_LI_Mem : Aleas_Manager Port Map(
           Next_Instruction_B_address => B_LI(3 downto 0),
           Next_Instruction_C_address => C_LI(3 downto 0),
           Next_Instruction_OP => OP_LI(3 downto 0),
           Current_Instruction_A_address => A_Mem(3 downto 0),
           Enable_IP_InstructionMemory => sig_enable_IP_and_InstMem,
           CLK => Sig_CLK);
                 
 -- Memoire de donnees (DATA_MEMORY) 
 
       uDm : Data_Memory Port Map(
                 Address => OUT_MUX_1_B_Mem,
                 INPUT => B_Mem,
                 RW => OUT_LC_OP_Mem,
                 RST => Sig_RST,
                 CLK => Sig_CLK,
                 OUTPUT => OUT_OUTPUT_DataMem,
                 EN => OUT_LC_A_Mem);
                 
-- Mem_RE 
       MEM_RE : Etage Port Map(
                 A_in => A_Mem,
                 OP_in => OP_Mem,
                 B_in => OUT_MUX_2_B_Mem,
                 C_in => x"00", -- no input 
                 A_out => A_RE,
                 OP_out => OP_RE,
                 B_out => B_RE,
                 C_out => open, -- no output 
                 CLK => Sig_CLK);
           
    
    -- Decoupage OUTPUT InstMem pour LI (A,OP,B,C)
    A_LI <= OUT_Instruction_InstMem(31 downto 24);
    OP_LI <= OUT_Instruction_InstMem(23 downto 16);
    B_LI <= OUT_Instruction_InstMem(15 downto 8);
    C_LI <= OUT_Instruction_InstMem(7 downto 0);

     -- MUX
    OUT_MUX_B_DI <= B_DI when (OP_DI(3 downto 0) = AFC_OP or OP_DI(3 downto 0) = LOAD_OP) else OUT_QA_Bench;
    OUT_MUX_B_EX <= OUT_S_ALU when (OP_EX(3 downto 0) >= ADD_OP and OP_EX(3 downto 0) <= DIV_OP) else B_EX;
    OUT_MUX_1_B_Mem <= A_Mem when (OP_Mem(3 downto 0) = LOAD_OP or OP_Mem(3 downto 0) = STORE_OP);
    OUT_MUX_2_B_Mem <= OUT_OUTPUT_DataMem when OP_Mem(3 downto 0) = LOAD_OP else B_Mem;

    -- LC
    OUT_LC_OP_EX <= OP_EX(3 downto 0) when (OP_EX(3 downto 0) >= ADD_OP and OP_EX(3 downto 0) <= DIV_OP) else x"0";
    OUT_LC_A_Mem <= A_Mem(6);
    OUT_LC_OP_Mem <= OP_Mem(6);
    OUT_LC_OP_RE <= OP_RE(7);      
    
end Behavioral; ---


----- COMPOSANT SCHEMATICS ------