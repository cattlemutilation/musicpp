----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:24:35 10/08/2019 
-- Design Name: 
-- Module Name:    rom - Behavioral 
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

--named rom but is actually ram
entity ram is
    Port ( clk : in  STD_LOGIC;
			  wr_en : in STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (9 downto 0);
			  data_in : in STD_LOGIC_VECTOR(7 downto 0);
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end ram;

architecture Behavioral of ram is

type ram_type is array (0 to 1023) of std_logic_vector(7 downto 0);
signal ram : ram_type := (others => (others => '0'));

begin

	ram_process: process(clk, addr) is
	variable var_addr : integer;
	
	begin
		if (falling_edge(clk)) then
			var_addr := conv_integer(addr);
			if wr_en = '1' then
				ram(var_addr) <= data_in;
			end if;
				data_out <= ram(var_addr);
		end if;			
	end process;
end Behavioral;

