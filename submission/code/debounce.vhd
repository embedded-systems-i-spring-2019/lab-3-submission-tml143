

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity debounce is
    Port ( BTN : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DBNC : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is
signal shiftreg : std_logic_vector (1 downto 0) := (others => '0');
signal counter : std_logic_vector(21 downto 0) := (others =>'0');
begin

process (clk)
begin

if (rising_edge(clk)) then
    shiftreg(1) <= shiftreg(0);
    shiftreg(0) <= BTN;
    
if (unsigned(counter)<= 2499999) then
    DBNC <= '0';
    if shiftreg(1) = '1' then
    counter <= std_logic_vector(unsigned(counter)+1);
    elsif (shiftreg(1)='0') then
    counter <= (others => '0');
    
    end if;
    
elsif (unsigned(counter)= 2500000) then
    if (shiftreg(1)='1') then
    DBNC <='1'; 
    else
    DBNC <='0';
    counter <= (others =>'0');
    end if;

end if;
end if;



end process;

end Behavioral;




