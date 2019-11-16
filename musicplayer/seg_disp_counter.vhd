----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:56:34 10/28/2019 
-- Design Name: 
-- Module Name:    seg_disp_counter - Behavioral 
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

entity seg_disp_counter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  en : in STD_LOGIC;
			  cnt : out std_logic_vector(1 downto 0);
           zero : out  STD_LOGIC);
end seg_disp_counter;

architecture Behavioral of seg_disp_counter is

signal disp_rotate_cnt : std_logic_vector(1 downto 0);

begin
	process(rst, clk)
	begin
		if(rst = '1') then
			disp_rotate_cnt <= "11";
		elsif (falling_edge(clk)) then
			if en = '1' then
				disp_rotate_cnt <= disp_rotate_cnt - 1;
			end if;
		end if;
	end process;
	cnt <= disp_rotate_cnt;
	zero <= '1' when disp_rotate_cnt = "00" else '0';

end Behavioral;

