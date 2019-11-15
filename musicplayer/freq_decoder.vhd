----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:08:34 10/03/2019 
-- Design Name: 
-- Module Name:    freq_decoder - Behavioral 
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

entity freq_decoder is
    Port ( note : in  STD_LOGIC_VECTOR (7 downto 0);
           count : out  STD_LOGIC_VECTOR (18 downto 0));
end freq_decoder;

architecture Behavioral of freq_decoder is

begin
	process(note)
	begin
		case(note) is
			when "01100001" =>
				count <= "1011101001011101111";
			when "01100010" =>
				count <= "1011000001000110011";
			when "01100011" =>
				count <= "1010011000010101000";
			when "01100100" =>
				count <= "1001110100000000111";
			when "01100101" =>
				count <= "1001001111110110110";
			when "01100110" =>
				count <= "1000101111101000101";
			when "01100111" =>
				count <= "1000101111101000101"; -- change this
			when "01101000" => 
				count <= "0111110010001111110" ;
			when "01101001"=> 
				count <= "0111010110101000100";
			when "01101010" => 
				count <= "0110111011111001001";
			when  "01101011" =>
				count <= "0110100011001000000";
			when  "01101100" => 
				count <= "0110001011010111101";
			when  "01101101" =>
				count <= "0101110101011100101" ;
			when "01101110" =>
				count <= "0101100000100011001" ;
			when "01101111" =>
				count <= "0101001100101110110" ;
			when "01110000" =>
				count <= "0100111010000000100" ;
			when "01110001" =>
				count <= "0100101000011000001";
			when "01110010"=>
				count <= "0100010111110100010";
			when "01110011"=>
				count <= "0100000111111011111";
			when "01110100" =>
				count <= "0011111001000111111" ;
			when "01110101"=> 
				count <= "0011101011000010001";
			when "01110110" =>
				count <= "0011011101111100100" ;
			when "01110111" =>
				count <= "0011010001100100000";
			when "01111000" =>
				count <= "0011000101101011111";
			when "01111001" =>
				count <= "0010111010100010111";
			when others =>
				count <= "0000000000000000000";
		end case;	
	end process;
--	count <= "1011101001011101111" when note = "01100001" else	--c4
--				"1011000001000110011" when note = "01100010" else	-- c#
--				"1010011000010101000" when note = "01100011" else	-- d4				
--				"1001110100000000111" when note = "01100100" else	-- d#
--				"1001001111110110110" when note = "01100101" else	-- e4
--				"1000101111101000101" when note = "01100110" else	-- f4
--				"1000101111101000101" when note = "01100111" else	-- f#
--				"0111110010001111110" when note = "01101000" else	-- g4
--				"0111010110101000100" when note = "01101001" else	-- g#
--				"0110111011111001001" when note = "01101010" else	-- a4
--				"0110100011001000000" when note = "01101011" else	-- a#
--				"0110001011010111101" when note = "01101100" else	-- b4
--				"0101110101011100101" when note = "01101101" else	-- c5
--				"0101100000100011001" when note = "01101110" else	-- c#
--				"0101001100101110110" when note = "01101111" else	-- d5
--				"0100111010000000100" when note = "01110000" else	-- d#
--				"0100101000011000001" when note = "01110001" else	-- e5
--				"0100010111110100010" when note = "01110010" else	-- f5
--				"0100000111111011111" when note = "01110011" else	-- f#
--				"0011111001000111111" when note = "01110100" else	-- g5
--				"0011101011000010001" when note = "01110101" else	-- g#
--				"0011011101111100100" when note = "01110110" else	-- a5
--				"0011010001100100000" when note = "01110111" else	-- a#
--				"0011000101101011111" when note = "01111000" else	-- b5
--				"0010111010100010111" when note = "01111001";	-- c6

end Behavioral;

