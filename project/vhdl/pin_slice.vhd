library ieee;
use ieee.std_logic_1164.all;

entity pin_slice is
    port(
        zi : in std_logic;
        qi : in std_logic;
        wi : in std_logic;
        ci : in std_logic;
        zo : out std_logic;
        qo : out std_logic;
        wo : out std_logic;
        co : out std_logic
    );
end pin_slice;

architecture rtl of pin_slice is

    signal g1_o : std_logic;
    signal g2_o : std_logic;

begin

    g1 : entity work.dffposx1 port map(ci, qi, g1_o);
    g2 : entity work.aoi21x1  port map(wi, g1_o, zi, g2_o);
    g3 : entity work.invx1    port map(g2_o, zo);

    -- pass through
    co <= ci;
    wo <= wi;
    qo <= g1_o;

end rtl;
