library ieee;
use ieee.std_logic_1164.all;

entity shift_slice_tb is
end shift_slice_tb;

architecture tb_rtl of shift_slice_tb is

    signal clki  : std_logic := '0';
    signal clko  : std_logic;
    signal ldi   : std_logic := '0';
    signal ldo   : std_logic;
    signal si    : std_logic := '0';
    signal so    : std_logic;
    signal z     : std_logic := '0';

    component shift_slice is
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

begin

    uut : shift_slice
    port map(
        clki  => clki,
        clko  => clko,
        ldi   => ldi  ,
        ldo   => ldo  ,
        si    => si   ,
        so    => so   ,
        z     => z
    );

    process
        type pattern_type is record
            -- inputs
            ldi, z, si : std_logic;
            -- output
            so : std_logic;
        end record;

        type pattern_array is array (natural range <>) of pattern_type;
        constant patterns : pattern_array :=
        --ldi  z  si   so
        (('0','0','0', '0'),
         ('0','0','1', '1'),
         ('0','1','0', '0'),
         ('0','1','1', '1'),
         ('1','0','0', '0'),
         ('1','0','1', '0'),
         ('1','1','0', '1'),
         ('1','1','1', '1'));

    begin
        -- check each pattern
        for i in patterns'range loop

            -- set the inputs
            ldi <= patterns(i).ldi;
            z   <= patterns(i).z;
            si  <= patterns(i).si;
            wait for 10 ns;

            -- pulse the clock and check clock passthrough
            clki <= '1';
            wait for 10 ns;
            assert clko = '1' report "SCLKO does not equal 1" severity error;
            assert ldo = patterns(i).ldi report "SCLKO does not equal 1" severity error;
            clki <= '0';
            wait for 10 ns;
            assert clko = '0' report "SCLKO does not equal 0" severity error;
            assert ldo = patterns(i).ldi report "SCLKO does not equal 1" severity error;

            -- check the output
            assert so = patterns(i).so report "SO is incorrect" severity error;

        end loop;

        report "Test Complete" severity note;
        wait;

    end process;

end tb_rtl;
