library ieee;
use ieee.std_logic_1164.all;

entity shift_slice is
    port(
        clki : in  std_logic;
        clko : out std_logic;
        ldi   : in  std_logic;
        ldo   : out std_logic;
        si    : in  std_logic;
        so    : out std_logic;
        z     : in  std_logic
    );
end shift_slice;

architecture rtl of shift_slice is

    signal g1_o : std_logic := '0';

begin

    g1 : entity work.mux2x1   port map(si, z, ldi, g1_o);
    g2 : entity work.dffposx1 port map(clki, g1_o, so);

    -- pass through
    clko <= clki;
    ldo <= ldi;

end rtl;
