library ieee;
use ieee.std_logic_1164.all;

entity top_test_tb is
end top_test_tb;

architecture tb_rtl of top_test_tb is

    constant n : integer := 3;

    signal psi  : std_logic := '0';
    signal pso  : std_logic;
    signal pclk : std_logic := '0';
    signal si   : std_logic := '0';
    signal so   : std_logic;
    signal sclk : std_logic := '0';
    signal ld   : std_logic := '0';
    signal test : std_logic := '0';

    component top
        generic(
            n : integer := n
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
    end component;

begin

    uut : top
    generic map(
        n => n
    )
    port map(
        psi  => psi,
        pso  => pso,
        pclk => pclk,
        si   => si,
        so   => so,
        sclk => sclk,
        ld   => ld,
        test => test
    );

    process
        procedure clock is begin
            sclk <= '1';
            wait for 20 ns;
            sclk <= '0';
            wait for 20 ns;
        end procedure clock;
    begin

        wait for 20 ns;

        -- pull test line high to enable test mode
        test <= '1';

        -- clock in a '1'
        si <= '1';
        wait for 20 ns;
        clock;

        -- clock in a '0'
        si <= '0';
        wait for 20 ns;
        clock;

        -- push the pulse through till just before the last FF
        -- (n*n)+n == number of flip flops
        -- 2 == we already did two clocks
        -- 1 == we want to stop before before final output
        for i in 1 to (n*n)+n-2-1 loop
            clock;
        end loop;

        -- check to make sure the bit in front of the pulse is 0
        assert so = '0' report "Bit leading pulse not zero";
        clock;
        -- check to make sure the pulse is 1
        assert so = '1' report "Pulse is not zero";
        clock;
        -- check to make sure the bit behind pulse is 0
        assert so = '0' report "Pulse trailing pulse not zero";
        clock;

        report "Test Complete" severity note;
        wait;

    end process;

end tb_rtl;

