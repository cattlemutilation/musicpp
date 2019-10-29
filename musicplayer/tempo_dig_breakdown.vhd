----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:27:06 10/23/2019 
-- Design Name: 
-- Module Name:    tempo_dig_breakdown - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tempo_dig_breakdown is
    Port (	tempo : in  STD_LOGIC_VECTOR (6 downto 0);
           dig3 : out  STD_LOGIC_VECTOR (3 downto 0);
           dig2 : out  STD_LOGIC_VECTOR (3 downto 0);
           dig1 : out  STD_LOGIC_VECTOR (3 downto 0));
end tempo_dig_breakdown;

architecture Behavioral of tempo_dig_breakdown is
	signal s3 : std_logic_vector(3 downto 0);
	signal s2 : std_logic_vector(3 downto 0);
	signal s1 : std_logic_vector(3 downto 0);
	
begin	

process(tempo)
begin
case tempo is
	when "0111100" =>
		s3 <= "0000";
		s2 <= "0110";
		s1 <= "0000";
	when "0111101" =>
		s3 <= "0000";
		s2 <= "0110";
		s1 <= "0001";
	when "0111110" =>
		s3 <= "0000";
		s2 <= "0110";
		s1 <= "0010";
	when "0111111" =>
		s3 <= "0000";
		s2 <= "0110";
		s1 <= "0011";
	when "1000000" =>
		s3 <= "0000";
		s2 <= "0110";
		s1 <= "0100";
	when "1000001" =>
		s3 <= "0000";
		s2 <= "0110";
		s1 <= "0101";
	when "1000010" =>
		s3 <= "0000";
		s2 <= "0110";
		s1 <= "0110";
	when "1000011" =>
		s3 <= "0000";
		s2 <= "0110";
		s1 <= "0111";
	when "1000100" =>
		s3 <= "0000";
		s2 <= "0110";
		s1 <= "1000";
	when "1000101" =>
		s3 <= "0000";
		s2 <= "0110";
		s1 <= "1001";
	when "1000110" =>
		s3 <= "0000";
		s2 <= "0111";
		s1 <= "0000";
	when "1000111" =>
		s3 <= "0000";
		s2 <= "0111";
		s1 <= "0001";
	when "1001000" =>
		s3 <= "0000";
		s2 <= "0111";
		s1 <= "0010";
	when "1001001" =>
		s3 <= "0000";
		s2 <= "0111";
		s1 <= "0011";
	when "1001010" =>
		s3 <= "0000";
		s2 <= "0111";
		s1 <= "0100";
	when "1001011" =>
		s3 <= "0000";
		s2 <= "0111";
		s1 <= "0101";
	when "1001100" =>
		s3 <= "0000";
		s2 <= "0111";
		s1 <= "0110";
	when "1001101" =>
		s3 <= "0000";
		s2 <= "0111";
		s1 <= "0111";
	when "1001110" =>
		s3 <= "0000";
		s2 <= "0111";
		s1 <= "1000";
	when "1001111" =>
		s3 <= "0000";
		s2 <= "0111";
		s1 <= "1001";
	when "1010000" =>
		s3 <= "0000";
		s2 <= "1000";
		s1 <= "0000";
	when "1010001" =>
		s3 <= "0000";
		s2 <= "1000";
		s1 <= "0001";
	when "1010010" =>
		s3 <= "0000";
		s2 <= "1000";
		s1 <= "0010";
	when "1010011" =>
		s3 <= "0000";
		s2 <= "1000";
		s1 <= "0011";
	when "1010100" =>
		s3 <= "0000";
		s2 <= "1000";
		s1 <= "0100";
	when "1010101" =>
		s3 <= "0000";
		s2 <= "1000";
		s1 <= "0101";
	when "1010110" =>
		s3 <= "0000";
		s2 <= "1000";
		s1 <= "0110";
	when "1010111" =>
		s3 <= "0000";
		s2 <= "1000";
		s1 <= "0111";
	when "1011000" =>
		s3 <= "0000";
		s2 <= "1000";
		s1 <= "1000";
	when "1011001" =>
		s3 <= "0000";
		s2 <= "1000";
		s1 <= "1001";
	when "1011010" =>
		s3 <= "0000";
		s2 <= "1001";
		s1 <= "0000";
	when "1011011" =>
		s3 <= "0000";
		s2 <= "1001";
		s1 <= "0001";
	when "1011100" =>
		s3 <= "0000";
		s2 <= "1001";
		s1 <= "0010";
	when "1011101" =>
		s3 <= "0000";
		s2 <= "1001";
		s1 <= "0011";
	when "1011110" =>
		s3 <= "0000";
		s2 <= "1001";
		s1 <= "0100";
	when "1011111" =>
		s3 <= "0000";
		s2 <= "1001";
		s1 <= "0101";
	when "1100000" =>
		s3 <= "0000";
		s2 <= "1001";
		s1 <= "0110";
	when "1100001" =>
		s3 <= "0000";
		s2 <= "1001";
		s1 <= "0111";
	when "1100010" =>
		s3 <= "0000";
		s2 <= "1001";
		s1 <= "1000";
	when "1100011" =>
		s3 <= "0000";
		s2 <= "1001";
		s1 <= "1001";
	when "1100100" =>
		s3 <= "0001";
		s2 <= "0000";
		s1 <= "0000";
	when "1100101" =>
		s3 <= "0001";
		s2 <= "0000";
		s1 <= "0001";
	when "1100110" =>
		s3 <= "0001";
		s2 <= "0000";
		s1 <= "0010";
	when "1100111" =>
		s3 <= "0001";
		s2 <= "0000";
		s1 <= "0011";
	when "1101000" =>
		s3 <= "0001";
		s2 <= "0000";
		s1 <= "0100";
	when "1101001" =>
		s3 <= "0001";
		s2 <= "0000";
		s1 <= "0101";
	when "1101010" =>
		s3 <= "0001";
		s2 <= "0000";
		s1 <= "0110";
	when "1101011" =>
		s3 <= "0001";
		s2 <= "0000";
		s1 <= "0111";
	when "1101100" =>
		s3 <= "0001";
		s2 <= "0000";
		s1 <= "1000";
	when "1101101" =>
		s3 <= "0001";
		s2 <= "0000";
		s1 <= "1001";
	when "1101110" =>
		s3 <= "0001";
		s2 <= "0001";
		s1 <= "0000";
	when "1101111" =>
		s3 <= "0001";
		s2 <= "0001";
		s1 <= "0001";
	when "1110000" =>
		s3 <= "0001";
		s2 <= "0001";
		s1 <= "0010";
	when "1110001" =>
		s3 <= "0001";
		s2 <= "0001";
		s1 <= "0011";
	when "1110010" =>
		s3 <= "0001";
		s2 <= "0001";
		s1 <= "0100";
	when "1110011" =>
		s3 <= "0001";
		s2 <= "0001";
		s1 <= "0101";
	when "1110100" =>
		s3 <= "0001";
		s2 <= "0001";
		s1 <= "0110";
	when "1110101" =>
		s3 <= "0001";
		s2 <= "0001";
		s1 <= "0111";
	when "1110110" =>
		s3 <= "0001";
		s2 <= "0001";
		s1 <= "1000";
	when "1110111" =>
		s3 <= "0001";
		s2 <= "0001";
		s1 <= "1001";
	when "1111000" =>
		s3 <= "0001";
		s2 <= "0010";
		s1 <= "0000";

	when others =>
		s3 <= "0000";
		s2 <= "0000";
		s1 <= "0000";
end case;
end process;

		 dig3 <= s3;
		 dig2 <= s2;
		 dig1 <= s1;

end Behavioral;

