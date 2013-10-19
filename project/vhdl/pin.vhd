library ieee;
use ieee.std_logic_1164.all;

entity pin is
    generic(
        n : integer := 3
    );
    port(
        clk : in  std_logic;
        psi : in  std_logic;
        pso : out std_logic;
        z   : out std_logic_vector((n-1) downto 0);
        w   : in  std_logic_vector((n-1) downto 0)
    );
end pin;

architecture rtl of pin is

    component pin_slice is
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
    end component;

    -- carray_array(row, col)
    type carry_array is array (0 to n, 0 to n) of std_logic;
    signal zc : carry_array;
    signal cc : carry_array;
    signal wc : carry_array;
    signal qc : carry_array;

    begin

    -- setup first and last inputs for each row
    z_connect : for i in 0 to n-1 generate
        zc(i, 0) <= '0';
        z(i) <= zc(i, n);
    end generate;

    -- setup first inputs for each column
    w_connect : for i in 0 to n-1 generate
        wc(0, i) <= w(i);
    end generate;

    -- setup row transfer
    -- (last output of row to first input of next row)
    r_connect : for i in 0 to n-2 generate
        qc(i, 0) <= qc(i+1, n);
        cc(i, 0) <= cc(i+1, n);
    end generate;

    -- connect external inputs
    qc(n-1, 0) <= psi;
    cc(n-1, 0) <= clk;
    pso <= qc(0, n);

    -- generate the grid of slices
    pin_z_gen : for zz in 0 to n-1 generate
        pin_w_gen : for ww in 0 to n-1 generate
            pin_i: pin_slice port map(
                zi => zc(zz, ww),
                qi => qc(zz, ww),
                wi => wc(zz, ww),
                ci => cc(zz, ww),
                zo => zc(zz, ww+1),
                qo => qc(zz, ww+1),
                wo => wc(zz+1, ww),
                co => cc(zz, ww+1)
            );
        end generate;
    end generate;

end rtl;
