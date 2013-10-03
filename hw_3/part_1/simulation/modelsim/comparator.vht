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
-- Generated on "09/27/2013 10:29:19"
                                                            
-- Vhdl Test Bench template for design  :  comparator
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY comparator_vhd_tst IS
generic (n : integer:=7);
END comparator_vhd_tst;
ARCHITECTURE comparator_arch OF comparator_vhd_tst IS                                                 
SIGNAL a : STD_LOGIC_VECTOR(n DOWNTO 0):="00000000";
SIGNAL b : STD_LOGIC_VECTOR(n DOWNTO 0):="00000000";
SIGNAL c : STD_LOGIC_VECTOR(n DOWNTO 0);
COMPONENT comparator
	PORT (
	a : IN STD_LOGIC_VECTOR(n DOWNTO 0);
	b : IN STD_LOGIC_VECTOR(n DOWNTO 0);
	c : OUT STD_LOGIC_VECTOR(n DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : comparator
	PORT MAP (
	a => a,
	b => b,
	c => c
	);                                      
Aprocess : PROCESS                                                                                 
BEGIN                                                         
  a<= "00100000";
   wait for 20ns;
  a<= "10000000";
  wait for 30ps; 
  a<="11100000";
  wait;	                                                        
END PROCESS;  

Bprocess : process
begin
  b<="01000000";
  wait for 50ns;
  b<="11100000";
  wait;   
end process;
  	
END comparator_arch;
