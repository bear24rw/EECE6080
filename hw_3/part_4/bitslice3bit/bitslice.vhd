
library ieee;
use ieee.std_logic_1164.all;

entity bitslice is
generic (n : integer :=2);
port(
a,b : in std_logic_vector(n downto 0);
f   : out std_logic_vector(n downto 0)
);
end entity;

architecture arc of bitslice is
signal c0,c1,c2,c3:std_logic;
signal cout :std_logic;
component slice is
port
(
	a : in std_logic;
	b : in std_logic;
	cin: in std_logic;
	s : in std_logic;
	cout:out std_logic;
	f :out std_logic
);
end component;
begin
b1: slice port map (a(0),b(0),c0,c3,c1,f(0));
b2: slice port map(a(1),b(1),c1,c3,c2,f(1));
b3: slice port map(a(2),b(2),c2,c3,c3,f(2));
c0<='0';
end architecture;