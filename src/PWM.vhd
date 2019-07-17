
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity PWM is
Port ( 
sys_clk_in: in std_logic;
sw_pin: in std_logic_vector(7 downto 0);
audio_pwm_o: out std_logic
);
end PWM;

architecture Behavioral of PWM is
signal cnt: integer:=0;
signal pwm: std_logic:='0';
signal count:integer;
signal freq: integer;
begin
process(sw_pin)
begin
case sw_pin is
when "00000000" => freq<=262;
when "00000001" => freq<=296;
when "00000010" => freq<=330;
when "00000011" => freq<=350;
when "00000100" => freq<=392;
when "00000101" => freq<=440;
when "00000110" => freq<=494;
when "00000111" => freq<=523;
when "00001000" => freq<=587;
when "00001001" => freq<=659;
when "00001010" => freq<=698;
when "00001011" => freq<=784;
when "00001100" => freq<=880;
when "00001101" => freq<=988;
when "00001110" => freq<=1047;
when "00001111" => freq<=1175;
when "00010000" => freq<=1319;
when "00010001" => freq<=1397;
when "00010010" => freq<=1568;
when "00010011" => freq<=1760;
when "00010100" => freq<=1976;
when others =>freq<=0;
end case;
end process;
process(sys_clk_in)
begin
if(freq>0)then
count<=100000000/freq;
else
count<=0;
end if;
if(sys_clk_in='1' and sys_clk_in'event)then
if count>0 then
if(cnt<count)then
cnt<=cnt+1;
else
cnt<=0;
end if;
if(cnt=count or cnt=(count+1)/2)then
pwm<= not pwm;
end if;
else
pwm<='0';
end if;
end if;
end process;
audio_pwm_o<=pwm;
end Behavioral;
