library ieee;
use ieee.std_logic_1164.all;

entity aoi21x1 is
    generic(delay : time := 0 ps);
    port(
        a : in std_logic;
        b : in std_logic;
        c : in std_logic;
        y : out std_logic
    );
end aoi21x1;

architecture rtl of aoi21x1 is begin
    process(a, b, c) begin
        y <= not ((a and b) or c) after delay;
    end process;
end rtl;
