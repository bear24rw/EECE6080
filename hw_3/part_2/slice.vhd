library ieee;
use ieee.std_logic_1164.all;

entity slice is
    port(
        a : in std_logic;
        b : in std_logic;
        s : in std_logic;
        f : out std_logic;
        c_i : in std_logic;
        c_o : out std_logic
    );
end slice;

architecture rtl of slice is begin

    process(a, b, s, c_i) begin

        -- comparator
        if (a = '1') and (b = '0') then
            c_o <= '0';
        elsif (a = '0') and (b = '1') then
            c_o <= '1';
        else
            c_o <= c_i;
        end if;

        -- mux
        if (s = '1') then
            f <= a;
        else
            f <= b;
        end if;

    end process;

end rtl;
