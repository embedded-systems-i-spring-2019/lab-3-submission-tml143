----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/21/2019 10:57:18 AM
-- Design Name: 
-- Module Name: uart_tx - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity uart_tx is
    Port ( clk, en, send, rst : in STD_LOGIC;
           char : in STD_LOGIC_VECTOR (7 downto 0);
           ready, tx : out STD_LOGIC);
end uart_tx;

architecture Behavioral of uart_tx is
 type state is (idle, start, data, stop);
 signal curr : state := idle;
 signal count : std_logic_vector(3 downto 0) := (others => '0');
 signal d : std_logic_vector(7 downto 0) := (others => '0');
begin

process(clk)
begin
if rising_edge(clk) then
if rst ='1' then
curr<= idle;
count <=(others => '0');
d<=(others => '0');
ready<='1';
tx<='1';
elsif en ='1' then
case curr is

    when idle =>
  
    if send ='1' then
    ready<='0';
    d<= char;
   -- tx <= '0';
    curr <= start;
    else
    ready<='1';
    tx<='1';
    curr <=idle;
    end if;
    
    when start =>
    tx <= '0';
    count<="0000";
    --tx<=d(to_integer(unsigned(count)));
    
    curr<=data;
    
    when data =>
    if (unsigned(count)<8) then
     --count <= std_logic_vector(unsigned(count)+1);
     tx<=d(to_integer(unsigned(count)));
     count <= std_logic_vector(unsigned(count)+1);
    
     curr <=data;
    else
    tx <='1';
    curr<=stop;
    end if;
    
    when stop =>
    ready <='1';
    curr<= idle;
    
    
    when others =>
    curr <= idle;

    end case;

end if;
end if;
end process;


end Behavioral;
