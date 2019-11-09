--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:39:22 11/09/2019
-- Design Name:   
-- Module Name:   C:/Users/jorilla/uni/musicpp/musicplayer/playertest.vhd
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
 
ENTITY playertest IS
END playertest;
 
ARCHITECTURE behavior OF playertest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT musicplayer
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         pdb : INOUT  std_logic_vector(7 downto 0);
         astb : IN  std_logic;
         dstb : IN  std_logic;
         pwr : IN  std_logic;
         pwait : OUT  std_logic;
         swt : IN  std_logic_vector(7 downto 0);
         led : OUT  std_logic_vector(7 downto 0);
         disp : OUT  std_logic_vector(3 downto 0);
         seg : OUT  std_logic_vector(6 downto 0);
         spk : INOUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal astb : std_logic := '0';
   signal dstb : std_logic := '0';
   signal pwr : std_logic := '0';
   signal swt : std_logic_vector(7 downto 0) := (others => '0');

	--BiDirs
   signal pdb : std_logic_vector(7 downto 0);
   signal spk : std_logic;

 	--Outputs
   signal pwait : std_logic;
   signal led : std_logic_vector(7 downto 0);
   signal disp : std_logic_vector(3 downto 0);
   signal seg : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: musicplayer PORT MAP (
          clk => clk,
          rst => rst,
          pdb => pdb,
          astb => astb,
          dstb => dstb,
          pwr => pwr,
          pwait => pwait,
          swt => swt,
          led => led,
          disp => disp,
          seg => seg,
          spk => spk
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
      wait for clk_period/2;	-- reset
		rst <= '1';
		astb <= '1';
		dstb <= '1';
		pwr <= '1';
		wait for clk_period;	-- ready
		rst <= '0';
		astb <= '0';
		pwr <= '0';
		wait for clk_period; -- awrA
		astb <= '1';
		pwr <= '1';
		wait for clk_period; -- awrB
		wait for clk_period; -- ready
		dstb <= '0';
		pwr <= '0';
		wait for clk_period; -- dwrA
		dstb <=  '1';
		pwr <= '1';
		wait for clk_period; -- dwrB
		pdb <= "11111111";
		wait for clk_period;
		dstb <= '0';
		pwr <= '0';
		wait for clk_period; -- dwrA
		dstb <=  '1';
		pwr <= '1';
		wait for clk_period; -- dwrB
		pdb <= "11110000";
		wait for clk_period; -- ready
		dstb <= '0';
		pwr <= '0';
		wait for clk_period; -- dwrA
		dstb <=  '1';
		pwr <= '1';
		wait for clk_period; -- dwrB
		pdb <= "01000000";
		wait for clk_period;
		wait for clk_period*100;
		
		
		
		

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
