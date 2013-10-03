library ieee;
use ieee.std_logic_1164.all;

entity nandgate3  is
port (
a,b,c :in std_logic;
d :out std_logic
);
end entity;

architecture arc of nandgate3 is
signal d1: std_logic;
begin
process(a,b,c)
begin
d1<=not(a and b and c);
end process;
d<=d1 after 528 ps;
end architecture;