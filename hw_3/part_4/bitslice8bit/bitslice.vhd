
library ieee;
use ieee.std_logic_1164.all;

entity bitslice is
generic (n : integer :=7);
port(
a,b : in std_logic_vector(n downto 0);
f   : out std_logic_vector(n downto 0)
);
end entity;

architecture arc of bitslice is
signal c0,c1,c2,c3,c4,c5,c6,c7,c8:std_logic;
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
b1: slice port map (a(0),b(0),c0,c8,c1,f(0));
b2: slice port map(a(1),b(1),c1,c8,c2,f(1));
b3: slice port map(a(2),b(2),c2,c8,c3,f(2));
b4: slice port map(a(3),b(3),c3,c8,c4,f(3));
b5: slice port map(a(4),b(4),c4,c8,c5,f(4));
b6: slice port map(a(5),b(5),c5,c8,c6,f(5));
b7: slice port map(a(6),b(6),c6,c8,c7,f(6));
b8: slice port map(a(7),b(7),c7,c8,c8,f(7));
c0<='0';
end architecture;