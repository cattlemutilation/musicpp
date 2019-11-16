----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:51:36 10/03/2019 
-- Design Name: 
-- Module Name:    beat_decoder - Behavioral 
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

entity tempo_decoder is
    Port ( tempo : in  STD_LOGIC_VECTOR (6 downto 0);
           beat_len : out  STD_LOGIC_VECTOR (27 downto 0));
end tempo_decoder;

architecture Behavioral of tempo_decoder is

begin
	-- theres probably a better way to do this by adding onto a base beat value
	-- but whatever
	process(tempo)
	begin
		case(tempo) is
			when "0111100"=>
				beat_len <= X"17d7840";
			when "0111101"=>
				beat_len <= X"1773753";
			when "0111110"=>
				beat_len <= X"1712a0c";
			when "0111111"=>
				beat_len <= X"16b4df3";
			when "1000000"=>
				beat_len <= X"165a0bc";
			when "1000001"=>
				beat_len <= X"160203b";
			when "1000010"=>
				beat_len <= X"15aca68";
			when "1000011"=>
				beat_len <= X"1559d5b";
			when "1000100"=>
				beat_len <= X"1509747";
			when "1000101"=>
				beat_len <= X"14bb67a";
			when "1000110"=>
				beat_len <= X"146f95b";
			when "1000111"=>
				beat_len <= X"1425e68";
			when "1001000"=>
				beat_len <= X"13de435";
			when "1001001"=>
				beat_len <= X"1398969";
			when "1001010"=>
				beat_len <= X"1354cbe";
			when "1001011"=>
				beat_len <= X"1312d00";
			when "1001100"=>
				beat_len <= X"12d290a";
			when "1001101"=>
				beat_len <= X"1293fc7";
			when "1001110"=>
				beat_len <= X"1257031";				
			when "1001111" =>
				beat_len <= X"121b94d";
			when "1010000"=>
				beat_len <= X"11e1a30";
			when "1010001"=>
				beat_len <= X"11a91f6";
			when "1010010"=>
				beat_len <= X"1171fca";
			when "1010011"=>
				beat_len <= X"113c2e1";
			when "1010100"=>
				beat_len <= X"1107a76";
			when "1010101"=>
				beat_len <= X"10d45d2";
			when "1010110"=>
				beat_len <= X"10a2444";
			when "1010111"=>
				beat_len <= X"1071523";
			when "1011000"=>
				beat_len <= X"10417ce";
			when "1011001"=>
				beat_len <= X"1012bac" ;
			when "1011010"=>
				beat_len <= X"0fe502a";
			when "1011011"=>
				beat_len <= X"0fb84bc";
			when "1011100"=>
				beat_len <= X"0f8c8db";
			when "1011101"=>
				beat_len <= X"0f61c08";
			when "1011110"=>
				beat_len <= X"0f37dc6";
			when "1011111"=>
				beat_len <= X"0f0eda1";
			when "1100000"=>
				beat_len <= X"0ee6b28";
			when "1100001" =>
				beat_len <= X"0ebf5ed";
			when "1100010" =>
				beat_len <= X"0e98d8a";
			when "1100011" =>
				beat_len <= X"0e7319b";
			when "1100100" =>
				beat_len <= X"0e4e1c0";
			when "1100101" =>
				beat_len <= X"0e29d9d";
			when "1100110" =>
				beat_len <= X"0e064da";
			when "1100111" =>
				beat_len <= X"0de3722";
			when "1101000" =>
				beat_len <= X"0dc1424";
			when "1101001" =>
				beat_len <= X"0d9fb92";
			when "1101010" =>
				beat_len <= X"0d7ed1f";
			when "1101011"=>
				beat_len <= X"0d5e883";
			when "1101100"=>
				beat_len <= X"0d3ed78";
			when "1101101"=>
				beat_len <= X"0d1fbbb";
			when "1101110"=>
				beat_len <= X"0d0130b";
			when "1101111"=>
				beat_len <= X"0ce3329";
			when "1110000"=>
				beat_len <= X"0cc5bd9";
			when "1110001"=>
				beat_len <= X"0ca8ce0";
			when "1110010"=>
				beat_len <= X"0c8c606";
			when "1110011"=>
				beat_len <= X"0c70716";
			when "1110100"=>
				beat_len <= X"0c54fda";
			when "1110101"=>
				beat_len <= X"0c3a020";
			when "1110110"=>
				beat_len <= X"0c1f7b8";
			when "1110111" =>
				beat_len <= X"0c05672";
			when "1111000" =>
				beat_len <= X"0bebc20";
			when others =>
				beat_len <= X"fffffff";
		end case;
	end process;

end Behavioral;

