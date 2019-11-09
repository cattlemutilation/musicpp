----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:58:29 11/08/2019 
-- Design Name: 
-- Module Name:    ram_addr_counter - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram_addr_counter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
           addr_out : out  STD_LOGIC_VECTOR (9 downto 0));
end ram_addr_counter;

architecture Behavioral of ram_addr_counter is
	signal count : std_logic_vector(9 downto 0);
begin
	process(clk, rst)
	begin
	if rst = '1' then
			count <= (others => '0');		
	elsif rising_edge(clk) then
		if	en = '1' then
				count <= count + 1;
		end if;	
	end if;
	end process;
	addr_out <= count;


end Behavioral;

