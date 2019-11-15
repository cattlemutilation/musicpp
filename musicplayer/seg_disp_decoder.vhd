----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:20:06 10/28/2019 
-- Design Name: 
-- Module Name:    seg_disp_decoder - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seg_disp_decoder is
    Port ( rotation : in  STD_LOGIC_VECTOR (1 downto 0);
           anode_enable : out  STD_LOGIC_VECTOR (3 downto 0));
end seg_disp_decoder;

architecture Behavioral of seg_disp_decoder is

begin
process(rotation)
	begin
	case(rotation) is
		when "11" =>
			anode_enable <= "1110";
		when "10" =>
			anode_enable <= "1101";
		when "01" =>
			anode_enable <= "1011";
		when others =>
			anode_enable <= "1111";
	end case;
end process;
end Behavioral;

