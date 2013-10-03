library ieee;
use ieee.std_logic_1164.all;

entity notgate is
port (
a :in std_logic;
b :out std_logic
);
end entity;

architecture arc of notgate is
signal b1: std_logic;
begin
process (a)
begin
b1<=not a;
end process;
b<=b1 after 256.55 ps; 
end architecture;