library ieee;
use ieee.std_logic_1164.all;

entity nandgate3  is
    port (
    a,b,c :in std_logic;
    d :out std_logic
);
end entity;

architecture arc of nandgate3 is
begin
    process(a,b,c) begin
        d <= not(a and b and c) after 528 ps;
    end process;
end architecture;
