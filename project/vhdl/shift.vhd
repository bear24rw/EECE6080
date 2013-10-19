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
        so  : out std_logic;
        z   : in  std_logic_vector((n-1) downto 0);
        w   : out std_logic_vector((n-1) downto 0)
    );
end shift;

architecture rtl of shift is

    component shift_slice
        port(
            clki  : in  std_logic;
            clko  : out std_logic;
            ldi   : in  std_logic;
            ldo   : out std_logic;
            si    : in  std_logic;
            so    : out std_logic;
            z     : in  std_logic
        );
    end component;

    -- vector to hold  values between slices
    signal c_so : std_logic_vector(n downto 0) := (others => '0');
    signal c_clk : std_logic_vector(n downto 0) := (others => '0');
    signal c_ld : std_logic_vector(n downto 0) := (others => '0');

    begin

    -- input of slice 0 comes from module input
    c_so(0) <= si;
    c_ld(0) <= ld;
    c_clk(0) <= clk;

    -- final shift output comes from output of last slice
    so <= c_so(n);

    -- generate N slices
    shift_gen : for i in 0 to n-1 generate
        shift_i: shift_slice port map(
            clki => c_clk(i),
            clko => c_clk(i+1),
            ldi => c_ld(i),
            ldo => c_ld(i+1),
            si => c_so(i),
            so => c_so(i+1),
            z => z(i)
        );
    end generate;

    -- connect the output of each slice to parallel output vector
    connect : for i in 0 to n-1 generate
        w(i) <= c_so(i+1);
    end generate;

end rtl;
