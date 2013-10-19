library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use work.txt_util.all;

entity top_tb is
    generic(
        stim_file : string := "vectors_3_bit.sim"
    );
end top_tb;

architecture tb_rtl of top_tb is

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
    end component;

    signal pin_vector    : std_logic_vector((n*n)-1 downto 0);
    signal shift_vector  : std_logic_vector(n-1 downto 0);
    signal result_vector : std_logic_vector(n-1 downto 0);

    file stimulus : TEXT open read_mode is stim_file;

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

        procedure clock_shifter is begin
            sclk <= '1';
            wait for 20 ns;
            sclk <= '0';
            wait for 20 ns;
        end procedure clock_shifter;

        procedure clock_pin is begin
            pclk <= '1';
            wait for 20 ns;
            pclk <= '0';
            wait for 20 ns;
        end procedure clock_pin;

        variable l: line;
        variable pin_str: string(1 to n*n);
        variable shf_str: string(1 to n);

    begin

        while not endfile(stimulus) loop

            -- load stimulus for this test
            readline(stimulus, l); read(l, pin_str);
            pin_vector <= to_std_logic_vector(pin_str);

            readline(stimulus, l); read(l, shf_str);
            shift_vector <= to_std_logic_vector(shf_str);

            readline(stimulus, l); read(l, shf_str);
            result_vector <= to_std_logic_vector(shf_str);

            wait for 100 ns;

            -- clock in the pin
            for i in 0 to (n*n)-1 loop
                psi <= pin_vector(i);
                wait for 20 ns;
                clock_pin;
            end loop;

            -- clock in the value
            for i in 0 to n-1 loop
                si <= shift_vector(i);
                wait for 20 ns;
                clock_shifter;
            end loop;

            -- pull latch high so the first result
            -- loop will trigger the latch
            ld <= '1';
            wait for 20 ns;

            -- clock out result and check it
            for i in 0 to n-1 loop
                clock_shifter;
                assert so = result_vector(i) report "Test Failed!";
                ld <= '0';
                wait for 20 ns;
            end loop;

        end loop;

        report "Test Complete" severity note;
        wait;

    end process;

end tb_rtl;

