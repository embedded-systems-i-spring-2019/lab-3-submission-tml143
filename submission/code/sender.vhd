
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;

entity sender is
    Port ( clk, en, reset, button, ready : in STD_LOGIC;
           send : out STD_LOGIC;
           char : out STD_LOGIC_VECTOR (7 downto 0));
end sender;

architecture Behavioral of sender is

type state is (idle, busyA, busyB, busyC );
signal curr : state := idle;
signal i : std_logic_vector(2 downto 0) := (others=>'0');

type str is array (0 to 5) of std_logic_vector(7 downto 0);
signal word : str := (x"74", x"6d", x"6c", x"31", x"34", x"33");
    
begin

process(clk)
begin
if rising_edge(clk) then
if reset ='1' then
send <='0';
char <=(others=>'0');
i<=(others=>'0');
curr<=idle;

elsif en='1' then
    case curr is
    
     when idle => 
     if (ready ='1' and button ='1' and unsigned(i)<6)then
     send <='1';
     char <= word(to_integer(unsigned(i)));
     i<= std_logic_vector(unsigned(i) + 1);
     curr<=busyA;
     elsif  (ready ='1' and button ='1' and unsigned(i)=6) then
     i<=(others=>'0');
     curr<=idle;
     end if;
     
     when busyA =>
     curr<=busyB;
     
     when busyB =>
     send <='0';
     curr<= busyC;
     
     when busyC =>
     if ready ='1' and button ='0' then
     curr<= idle;
     end if;
     
    when others =>
    curr <= idle;

    end case;

end if;
end if;

end process;

end Behavioral;
