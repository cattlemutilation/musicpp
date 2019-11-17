----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:51:27 10/04/2019 
-- Design Name: 
-- Module Name:    semiq_counter - Behavioral 
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

entity semiq_counter is
    Port ( clk : in std_logic;
				reset: in std_logic;
				en : in std_logic;
			 semi_len : in  STD_LOGIC_VECTOR (27 downto 0);
           zero: out std_logic);
end semiq_counter;

architecture Behavioral of semiq_counter is

signal count: std_logic_vector(27 downto 0);

begin
	process(clk, reset, semi_len)
		begin
			if(rising_edge(clk)) then
				if (reset = '1') then
					count <= semi_len;
				elsif (en = '1') then
					count <= count - 1;
				end if;
			end if;
	end process;
	zero <= '1' when count = 0 else '0';

end Behavioral;

