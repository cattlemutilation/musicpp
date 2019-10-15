----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:43:59 10/12/2019 
-- Design Name: 
-- Module Name:    addr_counter - Behavioral 
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

entity addr_counter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  en : in std_logic;
           addr_out : out  STD_LOGIC_VECTOR (10 downto 0));
end addr_counter;

architecture Behavioral of addr_counter is
signal counter: std_logic_vector(10 downto 0);
begin
	process(clk, rst)
		begin
			if(rst = '1') then
				counter <= (others => '0');
			elsif (falling_edge(clk) and en = '1') then
				counter <= counter + 1;
			end if;
		end process;
	
	addr_out <= counter;

end Behavioral;

