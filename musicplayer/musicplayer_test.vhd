--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:31:44 10/01/2019
-- Design Name:   
-- Module Name:   C:/Users/jorilla/musicplayer/musicplayer/musicplayer_test.vhd
-- Project Name:  musicplayer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: musicplayer
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
 
ENTITY musicplayer_test IS
END musicplayer_test;
 
ARCHITECTURE behavior OF musicplayer_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT musicplayer
    Port ( clock : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (15 downto 0);
			  addr : out std_Logic_Vector(22 downto 0);
			  swt : in std_Logic_vector(7 downto 0);
			  led : out std_logic_Vector(7 downto 0);
           spk : out  STD_LOGIC);
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal data : std_Logic_vector := (others => '0');
	
 	--Outputs
   signal speaker : std_logic;
	signal addr : Std_logic_Vector(22 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: musicplayer PORT MAP (
          clock => clock,
          char => char,
          speaker => speaker
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

      -- insert stimulus here 
		char <= "0101";
		wait for clock_period;
		char <= "0000";

      wait;
   end process;

END;
