

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity clock_div is
port(
      clk  : in std_logic;        
      new_clock : out std_logic     
    );
    
end clock_div;

architecture behavior of clock_div is

signal s_new_clock : std_logic:='0';
signal counter : std_logic_vector(26 downto 0) := (others => '0');

begin

 process(clk)
 begin
 new_clock <= s_new_clock;
 if rising_edge(clk) then
         --1085.06944444...                    
         if (unsigned(counter) <= 1085) then
                s_new_clock <= '0';
                counter <= std_logic_vector(unsigned(counter) + 1);   
         else
                new_clock <= (not s_new_clock);
                counter <= (others => '0');
                    
         end if;
                 end if;
    
    end process;
    
end behavior;