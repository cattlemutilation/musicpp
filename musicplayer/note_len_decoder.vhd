----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:02:18 10/04/2019 
-- Design Name: 
-- Module Name:    note_len_decoder - Behavioral 
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

entity note_len_decoder is
    Port ( note : in  STD_LOGIC_VECTOR (7 downto 0);
           semi_multiple : out  STD_LOGIC_VECTOR (4 downto 0));
end note_len_decoder;

architecture Behavioral of note_len_decoder is

begin
	semi_multiple <= "00001" when note = "00000001" else	-- semiquver
						  "00010" when note = "00000010" else	-- qver
						  "00100" when note = "00000011" else	-- crotchet
						  "01000" when note = "00000100" else	-- minim
						  "01100" when note = "00000101" else	-- dotted minim
						  "10000" when note = "00000110";		-- sembreve

end Behavioral;

