library ieee;                                               
use ieee.std_logic_1164.all;                                

entity fun_3_tb is
end fun_3_tb;

architecture rtl of fun_3_tb is

    constant n : integer := 3;

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
        a<="001";
        b<="001";
        wait for 10ns;
        a<="000";
        b<="001";
        wait for 10ns;
        wait;                                                        
    end process;

end rtl;
