library ieee;
use ieee.std_logic_1164.all;

entity fun is
    generic(
        n : integer := 8
    );
    port(
        a : in  std_logic_vector((n-1) downto 0);
        b : in  std_logic_vector((n-1) downto 0);
        f : out std_logic_vector((n-1) downto 0)
    );
end fun;

architecture rtl of fun is

    component slice
        port(
                a : in std_logic;
                b : in std_logic;
                s : in std_logic;
                f : out std_logic;
                c_i : in std_logic;
                c_o : out std_logic
            );
    end component;

    -- vector to hold carry values between slices
    signal carry : std_logic_vector(n downto 0) := (others => '0');

    begin
    fun_gen : for i in 0 to n-1 generate
        slice_i: slice port map(
            a => a(i),
            b => b(i),
            f => f(i),
            c_o => carry(i+1),  -- i+1 because carry(0) is initial
            c_i => carry(i),    -- carry(i) is c_o of previous slice
            s => carry(n)       -- mux uses output of last slice
        );
    end generate;

end rtl;
