library ieee;
use ieee.std_logic_1164.all;

entity pin_slice_tb is
end pin_slice_tb;

architecture tb_rtl of pin_slice_tb is

    signal zi : std_logic := '0';
    signal qi : std_logic := '0';
    signal wi : std_logic := '0';
    signal ci : std_logic := '0';
    signal zo : std_logic;
    signal qo : std_logic;
    signal wo : std_logic;
    signal co : std_logic;

    component pin_slice
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

begin

    uut : pin_slice
    port map(
        zi => zi,
        qi => qi,
        wi => wi,
        ci => ci,
        zo => zo,
        qo => qo,
        wo => wo,
        co => co
    );

    process
        type pattern_type is record
            -- inputs
            zi, qi, wi : std_logic;
            -- output
            zo : std_logic;
        end record;

        type pattern_array is array (natural range <>) of pattern_type;
        constant patterns : pattern_array :=
        --zi  qi  wi   zo
        (('0','0','0', '0'),
         ('0','0','1', '0'),
         ('0','1','0', '0'),
         ('0','1','1', '1'),
         ('1','0','0', '1'),
         ('1','0','1', '1'),
         ('1','1','0', '1'),
         ('1','1','1', '1'));

    begin
        -- check each pattern
        for i in patterns'range loop

            -- set the inputs
            zi <= patterns(i).zi;
            qi <= patterns(i).qi;
            wi <= patterns(i).wi;

            -- pulse the clock and check clock passthrough
            ci <= '1';
            wait for 10 ns;
            assert co = '1' report "CO does not equal 1" severity error;
            ci <= '0';
            wait for 10 ns;
            assert co = '0' report "CO does not equal 0" severity error;

            -- check the outputs
            assert qo = patterns(i).qi report "QI not equal QO" severity error;
            assert zo = patterns(i).zo report "ZO does not match pattern" severity error;

        end loop;

        report "Test Complete" severity note;
        wait;

    end process;

end tb_rtl;
