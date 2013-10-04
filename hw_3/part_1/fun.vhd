library IEEE;
use ieee.std_logic_1164.all;

entity fun is
    generic(
        n : integer := 8
    );
    port(
        a   : in  std_logic_vector(n-1 downto 0);
        b   : in  std_logic_vector(n-1 downto 0);
        f   : out std_logic_vector(n-1 downto 0)
    );
end entity;

architecture rtl of fun is
begin
    process (a,b) begin
        if(a<b) then
            f <= a;
        else
            f <= b;
        end if;
    end process;
end rtl;
