library ieee;
use ieee.std_logic_1164.all;

entity fun_8_tb is
end fun_8_tb;

architecture rtl of fun_8_tb is

    constant n : integer := 8;

    signal a : std_logic_vector(n-1 downto 0);
    signal b : std_logic_vector(n-1 downto 0);
    signal f : std_logic_vector(n-1 downto 0);

    component fun
        generic(
            n : integer := 8
        );
        port(
            a : in  std_logic_vector(n-1 downto 0);
            b : in  std_logic_vector(n-1 downto 0);
            f : out std_logic_vector(n-1 downto 0)
        );
    end component;

begin

    uut : fun
    generic map(
        n => n
    )
    port map(
        a => a,
        b => b,
        f => f
    );

    process begin
        a<="00000001";
        b<="00000001";
        wait for 100 ns;
        a<="00000000";
        b<="00000001";
        wait for 100 ns;
        a<="00000001";
        b<="00000001";
        wait for 100 ns;
        wait;
    end process;

end rtl;
