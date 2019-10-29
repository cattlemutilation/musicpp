----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:11:25 10/28/2019 
-- Design Name: 
-- Module Name:    seg_disp_clk_4ms - Behavioral 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seg_disp_clk_4ms is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
           zero : out  STD_LOGIC);
end seg_disp_clk_4ms;

architecture Behavioral of seg_disp_clk_4ms is

signal count : std_logic_vector(18 downto 0);

begin
	process(rst, clk)
	begin		
		if(falling_edge(clk)) then
			if(rst = '1') then
				count <= "1100001101001111111";	-- counts 4 ms for each digit display 400,000
			elsif en = '1' then
				count <= count - 1;
			end if;
		end if;
	end process;
	zero <= '1' when count = 0 else '0';


end Behavioral;

