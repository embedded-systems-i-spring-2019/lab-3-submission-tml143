

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity top_level_design is
    Port ( TXD : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (1 downto 0);
           clk : in STD_LOGIC;
           CTS : out STD_LOGIC;
           RTS : out STD_LOGIC;
           RXD : out STD_LOGIC);
end top_level_design;

architecture Behavioral of top_level_design is

component uart port
    (
       clk, en, send, rx, rst  : in std_logic;
       charSend                : in std_logic_vector (7 downto 0);
       ready, tx, newChar      : out std_logic;
       charRec                 : out std_logic_vector (7 downto 0)
    );
    end component;

component sender port
        (
           clk, en, reset, button, ready : in STD_LOGIC;
           send : out STD_LOGIC;
           char : out STD_LOGIC_VECTOR (7 downto 0)
            );
        end component;
           
component clock_div port
(
  clk  : in std_logic;        
  new_clock : out std_logic 
);
end component;

component debounce 
port(
    BTN : in STD_LOGIC;
    CLK : in STD_LOGIC;
    DBNC : out STD_LOGIC
);end component;

signal s_u1, s_u2, s_new_clock, s_ready, s_send : std_logic;
signal s_char : std_logic_vector(7 downto 0);
begin

u1: debounce 
port map(
BTN => btn(0),
CLK =>  clk,
DBNC =>s_u1
);

u2: debounce 
port map(
BTN => btn(1),
CLK =>  clk,
DBNC =>s_u2
);

u3: clock_div
port map(
clk => clk,
new_clock => s_new_clock
);

u4: sender
port map(
clk => clk,
en => s_new_clock,
button => s_u2,
reset => s_u1,
ready => s_ready,
char => s_char,
send => s_send
);

u5: uart
port map(
charSend =>s_char,
clk => clk,
en => s_new_clock,
rst => s_u1,
rx => TXD,
send => s_send,
ready => s_ready,
tx => RXD
);
CTS <='0';
RTS <='0';
end Behavioral;
