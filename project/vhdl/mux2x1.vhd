library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
    generic(delay : time := 0.2571 ns);
    port(
        a : in std_logic;
        b : in std_logic;
        s : in std_logic;
        y : out std_logic
    );
end mux2x1;

architecture rtl of mux2x1 is begin
    process(a, b, s) begin
        if (s = '1') then
            y <= b after delay;
        else
            y <= a after delay;
        end if;
    end process;
end rtl;
