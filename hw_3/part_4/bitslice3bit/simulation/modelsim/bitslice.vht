-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "10/01/2013 14:11:57"
                                                            
-- Vhdl Test Bench template for design  :  bitslice
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY bitslice_vhd_tst IS
END bitslice_vhd_tst;
ARCHITECTURE bitslice_arch OF bitslice_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL a : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL b : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL f : STD_LOGIC_VECTOR(2 DOWNTO 0);
COMPONENT bitslice
	PORT (
	a : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	b : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	f : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : bitslice
	PORT MAP (
-- list connections between master ports and signals
	a => a,
	b => b,
	f => f
	);
                                         
a1 : PROCESS                                                                                 
BEGIN                                                         
a<="010";
wait for 10ns;
a<="001";
wait for 10ns;
a<= "111";       
WAIT;                                                        
END PROCESS a1; 
b1 : process
begin
b<="111";
wait for 10ns;
b<="001";
wait for 10ns;
b<="110";
wait;
end process b1;                                       
END bitslice_arch;
