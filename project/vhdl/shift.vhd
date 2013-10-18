library ieee;
use ieee.std_logic_1164.all;

entity shift is
    generic(
        n : integer := 3
    );
    port(
        clk : in  std_logic;
        ld  : in  std_logic;
        si  : in  std_logic;
        z   : in  std_logic_vector((n-1) downto 0);
        w   : out std_logic_vector((n-1) downto 0)
    );
end shift;

architecture rtl of shift is

    component shift_slice
        port(
            sclki : in  std_logic;
            sclko : out std_logic;
            ldi   : in  std_logic;
            ldo   : out std_logic;
            si    : in  std_logic;
            so    : out std_logic;
            z     : in  std_logic
        );
    end component;

    -- vector to hold  values between slices
    signal so : std_logic_vector(n downto 0) := (others => '0');
    signal clko : std_logic_vector(n downto 0) := (others => '0');
    signal ldo : std_logic_vector(n downto 0) := (others => '0');

    begin

    -- input of slice 0 comes from module input
    so(0) <= si;
    ldo(0) <= ld;
    clko(0) <= clk;

    -- generate N slices
    shift_gen : for i in 0 to n-1 generate
        shift_i: shift_slice port map(
            sclki => clko(i),
            sclko => clko(i+1),
            ldi => ldo(i),
            ldo => ldo(i+1),
            si => so(i),
            so => so(i+1),
            z => z(i)
        );
    end generate;

    -- connect the output of each slice to final output vector
    connect : for i in 0 to n-1 generate
        w(i) <= so(i+1);
    end generate;

end rtl;
