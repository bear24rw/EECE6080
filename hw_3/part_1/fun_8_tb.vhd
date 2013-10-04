library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity fun_8_tb is
end fun_8_tb;

architecture tb_rtl of fun_8_tb is

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
        for aa in 0 to (2**n)-1 loop
            for bb in 0 to (2**n)-1 loop

                a <= std_logic_vector(to_unsigned(aa, a'length));
                b <= std_logic_vector(to_unsigned(bb, b'length));
                wait for 10 ns;
                if (a < b) then
                    assert f = a report "C not less than A" severity error;
                else
                    assert f = b report "A not less than C" severity error;
                end if;

            end loop;
        end loop;
        report "Test Complete" severity note;
        wait;
    end process;

end tb_rtl;
