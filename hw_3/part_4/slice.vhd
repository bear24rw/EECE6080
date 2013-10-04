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
);
end slice;

architecture rtl of slice is
    -- comparator
    signal g1_o : std_logic;
    signal g2_o : std_logic;
    signal g3_o : std_logic;
    signal g4_o : std_logic;

    -- mux
    signal g6_o : std_logic;
    signal g7_o : std_logic;
    signal g8_o : std_logic;

begin

    -- comparator
    g1 : entity work.notgate   port map(a,   g1_o);
    g2 : entity work.nandgate2 port map(b,   g1_o, g2_o);
    g3 : entity work.nandgate2 port map(c_i, g1_o, g3_o);
    g4 : entity work.nandgate2 port map(c_i, b,    g4_o);
    g5 : entity work.nandgate3 port map(g2_o, g3_o, g4_o, c_o);

    -- mux
    g6 : entity work.notgate   port map(s, g6_o);
    g7 : entity work.nandgate2 port map(s, a, g7_o);
    g8 : entity work.nandgate2 port map(b, g6_o, g8_o);
    g9 : entity work.nandgate2 port map(g7_o, g8_o, f);

end architecture;
