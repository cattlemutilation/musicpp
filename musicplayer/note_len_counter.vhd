----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:56:36 10/08/2019 
-- Design Name: 
-- Module Name:    note_len_counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.std_Logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity note_len_counter is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  en	: in std_logic;
           semi_multiples : in  STD_LOGIC_VECTOR (4 downto 0);
           zero : out  STD_LOGIC);
end note_len_counter;

architecture Behavioral of note_len_counter is

signal count : std_logic_vector(4 downto 0);

begin
	process(clk, reset, semi_multiples)	-- added semi multiples bc of synthesis complaint
		begin
			if (reset = '1') then
				count <= semi_multiples;
			elsif (clk'event and clk = '0' and en = '1') then
				count <= count - 1;
			end if;
		end process;
		zero <= '1' when count = 0 else '0';
end Behavioral;

