library ieee;
use ieee.std_logic_1164.all;

entity nandgate2  is
    port (
    a,b :in std_logic;
    c :out std_logic
);
end entity;

architecture arc of nandgate2 is
begin
    process(a,b) begin
        c <= not(a and b) after 259.5 ps;
    end process;
end architecture;
