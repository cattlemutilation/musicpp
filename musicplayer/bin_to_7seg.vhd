----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:00:41 10/23/2019 
-- Design Name: 
-- Module Name:    bin_to_7seg - Behavioral 
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

entity bin_to_7seg is
    Port ( digit : in  STD_LOGIC_VECTOR (3 downto 0);
           disp_7seg : out  STD_LOGIC_VECTOR (6 downto 0));
end bin_to_7seg;

architecture Behavioral of bin_to_7seg is

begin
process(digit)
	begin
		case(digit) is
			when "0000" =>
				disp_7seg <= "1000000";
			when "0001"=>
				disp_7seg <= "1111001";
			when "0010" =>
				disp_7seg <= "0100100";
			when "0011"=>
				disp_7seg <= "0110000";
			when "0100"=>
				disp_7seg <= "0011001";
			when "0101"=>
				disp_7seg <= "0010010";
			when "0110"=>
				disp_7seg <= "0000010";
			when "0111"=>
				disp_7seg <= "1111000";
			when "1000"=>
				disp_7seg <= "0000000";
			when "1001"=>
				disp_7seg <= "0011000";
			when others =>
				disp_7seg <= "1111111";	
		end case;
	end process;
end Behavioral;

