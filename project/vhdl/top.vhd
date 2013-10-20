library ieee;
use ieee.std_logic_1164.all;

entity top is
    generic(
        n : integer := 3
    );
    port(
        psi  : in  std_logic;
        pso  : out std_logic;
        pclk : in  std_logic;
        si   : in  std_logic;
        so   : out std_logic;
        sclk : in  std_logic;
        ld   : in  std_logic;
        test : in  std_logic
    );
end top;

architecture rtl of top is

    -- output of pin
    signal z : std_logic_vector((n-1) downto 0) := (others => '0');
    -- parallel output of shifter
    signal w : std_logic_vector((n-1) downto 0) := (others => '0');

    signal pin_clk : std_logic;
    signal pin_psi : std_logic;
    signal pin_pso : std_logic;
    signal shift_out : std_logic;

begin

    -- test mode mux connects shifter and pin together
    test_mux_1 : entity work.mux2x1 port map(pclk,      sclk,      test, pin_clk);
    test_mux_2 : entity work.mux2x1 port map(psi ,      shift_out, test, pin_psi);
    test_mux_3 : entity work.mux2x1 port map(shift_out, pin_pso,   test, so);

    pin : entity work.pin
    generic map(
        n => n
    )
    port map(
        clk => pin_clk,
        psi => pin_psi,
        pso => pin_pso,
        z => z,
        w => w
    );

    pso <= pin_pso;

    shifter : entity work.shift
    generic map(
        n => n
    )
    port map(
        clk => sclk,
        si => si,
        so => shift_out,
        ld => ld,
        z => z,
        w => w
    );

end rtl;
