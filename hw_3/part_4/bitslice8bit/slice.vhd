library ieee;
use ieee.std_logic_1164.all;

entity slice is
port(
a,b,cin,s:in std_logic;
cout,f :out std_logic
);
end entity;

architecture arc of slice is
signal cout1,f1: std_logic;
signal d,e,g,h,i,j,k :std_logic;

component notgate is
port
(
a :in std_logic;
b :out std_logic
);
end component;

component nandgate2 is
port
(
a ,b:in std_logic;
c :out std_logic
);
end component;

component nandgate3 is
port
(
a,b,c:in std_logic;
d:out std_logic
);
end component;
begin

u1: notgate port map(b,d);
u2: notgate port map(s,i);
u3: nandgate2 port map(d,cin,e);
u4: nandgate2 port map(d,a,g);
u5: nandgate2 port map(a,cin,h);
u6: nandgate2 port map(a,i,j);
u7: nandgate2 port map(s,b,k);
u8: nandgate2 port map(j,k,f);
u9: nandgate3 port map(e,g,h,cout);

end architecture;
