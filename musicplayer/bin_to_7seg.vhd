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
		disp_7seg <= "1000000" when digit = "0000" else
						"1111001" when digit = "0001" else
						"0100100" when digit = "0010" else
						"0110000" when digit = "0011" else
						"0011001" when digit = "0100" else
						"0010010" when digit = "0101" else
						"0000010" when digit = "0110" else
						"1111000" when digit = "0111" else
						"0000000" when digit = "1000" else
						"0011000" when digit = "1001" else
						"1111111";
end Behavioral;

