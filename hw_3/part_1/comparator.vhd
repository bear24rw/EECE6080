library IEEE;
use ieee.std_logic_1164.all;

entity comparator is
generic (n : integer:=7);
port(
	a,b: in std_logic_vector(n downto 0);
	c  : out std_logic_vector(n downto 0)
);
end entity;
architecture arc of comparator is
	begin
		process (a,b)
		begin
		if(a<b)
		then c<=a;
		elsif(a>=b)
		then c<=b;
	   end if;
	end process;
end arc;