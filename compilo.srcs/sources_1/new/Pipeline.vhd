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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pipeline is
--  Port ( );
end Pipeline;

architecture Behavioral of Pipeline is
    
    COMPONENT Instruction_Memory 
    Port ( Address : in STD_LOGIC_VECTOR(7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR(31 downto 0));
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
           Ctrl_Alu : in STD_LOGIC_VECTOR(2 downto 0));
     END COMPONENT;
     
     COMPONENT Data_Memory 
     Port (Address : in STD_LOGIC_VECTOR(7 downto 0);
           INPUT : in STD_LOGIC_VECTOR(7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR(7 downto 0));
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
signal sig_CLK : STD_LOGIC;
signal sig_RST : STD_LOGIC;

-- Signaux "speciaux"

signal OUT_QA_Bench : STD_LOGIC_VECTOR(7 downto 0);
signal OUT_MUX_B_DI : STD_LOGIC_VECTOR(7 downto 0);

signal OUT_LC_OP_EX : STD_LOGIC_VECTOR(2 downto 0); 
signal OUT_S_ALU : STD_LOGIC_VECTOR(7 downto 0);
signal OUT_MUX_B_EX : STD_LOGIC_VECTOR(7 downto 0);

signal OUT_LC_OP_Mem : STD_LOGIC; 
signal OUT_MUX_1_B_Mem : STD_LOGIC_VECTOR(7 downto 0);
signal OUT_MUX_2_B_Mem : STD_LOGIC_VECTOR(7 downto 0);
signal OUT_OUTPUT_DataMem : STD_LOGIC_VECTOR(7 downto 0);

signal OUT_LC_OP_RE : STD_LOGIC; 

signal IN_Address_InstMem : STD_LOGIC_VECTOR(7 downto 0);
signal OUT_OUTPUT_InstMem : STD_LOGIC_VECTOR(31 downto 0);


begin

-- Mapping 

-- Memoire d'instructions (INSTUCTION_MEMORY) 
    uIm : Instruction_Memory Port Map ( 
           Address => IN_Address_InstMem,
           CLK => Sig_CLK,
           OUTPUT => OUT_OUTPUT_InstMem); 

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
           QB => C_DI );
           
 -- ALU 
    uAlu : ALU Port Map(
           A => B_EX,
           B => C_EX,
           S => OUT_S_ALU,
           --N => 
           --O => 
           --Z =>
           --C => 
           Ctrl_Alu => OUT_LC_OP_EX);
           
 -- Memoire de donnees (DATA_MEMORY) 
 
    uDm : Data_Memory Port Map(
           Address => OUT_MUX_1_B_Mem,
           INPUT => B_Mem,
           RW => OUT_LC_OP_Mem,
           RST => Sig_RST,
           CLK => Sig_CLK,
           OUTPUT => OUT_OUTPUT_DataMem);
   
    
    -- Decoupage OUTPUT InstMem pour LI (A,OP,B,C)
    A_LI <= OUT_OUTPUT_InstMem(7 downto 0);
    OP_LI <= OUT_OUTPUT_InstMem(15 downto 8);
    B_LI <= OUT_OUTPUT_InstMem(23 downto 16);
    C_LI <= OUT_OUTPUT_InstMem(31 downto 24);

    -- MUX
    OUT_MUX_B_DI <= OUT_QA_Bench OP_DI B_DI;
    OUT_MUX_B_EX <= OUT_S_ALU OP_EX B_EX;
    OUT_MUX_1_B_Mem <= A_Mem OP_Mem B_Mem ;
    OUT_MUX_2_B_Mem <= OUT_OUTPUT_DataMem OP_Mem B_Mem;
    
    -- LC
    OUT_LC_OP_EX <= '1' when OP_EX > 3;
    OUT_LC_OP_Mem <= OP_Mem();
    OUT_LC_OP_RE <= OP_Mem();
    
end Behavioral;
