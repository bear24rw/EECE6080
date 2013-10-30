library ieee;
use ieee.std_logic_1164.all;

entity invx1 is
    generic(delay : time := 0 ps);
    port(
        a : in std_logic;
        y : out std_logic
    );
end invx1;

architecture rtl of invx1 is begin
    y <= not a after delay;
end rtl;
