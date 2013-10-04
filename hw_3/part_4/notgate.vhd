library ieee;
use ieee.std_logic_1164.all;

entity notgate is
    port (
             a :in std_logic;
             b :out std_logic
         );
end entity;

architecture arc of notgate is
begin
    process (a) begin
        b <= not a after 256.55 ps;
    end process;
end architecture;
