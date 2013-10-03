library ieee;
use ieee.std_logic_1164.all;

entity nandgate2  is
port (
a,b :in std_logic;
c :out std_logic
);
end entity;

architecture arc of nandgate2 is
signal c1: std_logic;
begin
process(a,b)
begin
c1<=not(a and b);
end process;
c<=c1 after 259.5 ps;
end architecture;
