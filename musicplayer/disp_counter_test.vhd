--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:01:44 10/28/2019
-- Design Name:   
-- Module Name:   C:/Users/jorilla/musicplayer/musicplayer/disp_counter_test.vhd
-- Project Name:  musicplayer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: seg_disp_counter
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
 
ENTITY disp_counter_test IS
END disp_counter_test;
 
ARCHITECTURE behavior OF disp_counter_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT seg_disp_counter
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         en : IN  std_logic;
         zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';
	
 	--Outputs
   signal zero : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: seg_disp_counter PORT MAP (
          clk => clk,
          rst => rst,
          en => en,
          zero => zero
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		rst <= '1';
		wait for clk_period;
		rst <= zero;

      en <= '1';
		
		wait for clk_period*10;
		
		en<= '0';
		wait for clk_period*10;
		en <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
