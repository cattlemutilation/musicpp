--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:36:57 10/23/2019
-- Design Name:   
-- Module Name:   C:/Users/jorilla/musicplayer/musicplayer/test_tempo_split.vhd
-- Project Name:  musicplayer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: tempo_dig_breakdown
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_tempo_split IS
END test_tempo_split;
 
ARCHITECTURE behavior OF test_tempo_split IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT tempo_dig_breakdown
    PORT(
			clock : in std_logic;
         tempo : in  std_logic_vector(6 downto 0);
         dig3 : OUT  std_logic_vector(3 downto 0);
         dig2 : OUT  std_logic_vector(3 downto 0);
         dig1 : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

 	--Outputs
   signal tempo : std_logic_vector(6 downto 0);
   signal dig3 : std_logic_vector(3 downto 0);
   signal dig2 : std_logic_vector(3 downto 0);
   signal dig1 : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace clock below with 
   -- appropriate port name 
	signal clock : std_logic;
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: tempo_dig_breakdown PORT MAP (
			clock => clock,
          tempo => tempo,
          dig3 => dig3,
          dig2 => dig2,
          dig1 => dig1
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      tempo <= "0010000";
		wait for clock_period*4;
		tempo <= "1010101";
		wait for clock_period;
		tempo <= "0111100";
		wait for clock_period;
		tempo <= "1011110";

      -- insert stimulus here 

      wait;
   end process;

END;
