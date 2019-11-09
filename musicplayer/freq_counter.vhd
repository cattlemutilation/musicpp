----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:29:41 10/03/2019 
-- Design Name: 
-- Module Name:    freq_counter - Behavioral 
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity freq_counter is
    Port ( clk : in STD_LOGIC;
           reset : in  STD_LOGIC;
			  en : in std_logic;
				max_count : in  STD_LOGIC_VECTOR (18 downto 0);
           zero : out  STD_LOGIC);
end freq_counter;

architecture Behavioral of freq_counter is
signal count : std_logic_vector(18 downto 0);
begin
	process(clk, reset)
		begin					
			if(reset = '1') then
				count <= max_count;
			elsif (falling_edge(clk) and en = '1') then
				count <= count - 1;
			end if;
	end process;	
	zero <= '1' when count = "0000000000000000000" else '0';

end Behavioral;

