----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:30:47 10/01/2019 
-- Design Name: 
-- Module Name:    musicplayer - Behavioral 
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
library UNISIM;
use UNISIM.VComponents.all;

entity musicplayer is
    Port ( clk : in  STD_LOGIC;
				rst : in std_logic;

				pdb : inout std_logic_vector(7 downto 0);
				astb : in std_logic;
				dstb : in std_logic;
				pwr : in std_logic;
				pwait : out std_logic;			  
			  
			  swt : in std_logic;
			  --swt : in std_Logic_vector(7 downto 0);
			  led : out std_logic_Vector(7 downto 0);
			  disp : out std_logic_vector(3 downto 0);	-- which led is lit
			  seg : out std_logic_vector(6 downto 0);		-- which segments of 7seg display are lit
           spk : inout  STD_LOGIC);
end musicplayer;

architecture Behavioral of musicplayer is
------------------------------------------------------------------------
-- Component Declaration
------------------------------------------------------------------------
	component freq_decoder is
		 Port ( note : in  STD_LOGIC_VECTOR (7 downto 0);
				  count : out  STD_LOGIC_VECTOR (18 downto 0));
	end component;

	component  freq_counter is
		 Port ( clk : in STD_LOGIC;
				  reset : in  STD_LOGIC;
				  en	: in std_logic;
					max_count : in  STD_LOGIC_VECTOR (18 downto 0);
				  zero : out  STD_LOGIC);
	end component;

	component note_len_decoder is
		 Port ( note : in  STD_LOGIC_VECTOR (7 downto 0);
				  semi_multiple : out  STD_LOGIC_VECTOR (4 downto 0));
	end component;

	component note_len_counter is
		 Port ( clk : in  STD_LOGIC;
				  reset : in  STD_LOGIC;
				  en : in std_logic;
				  semi_multiples : in  STD_LOGIC_VECTOR (4 downto 0);
				  zero : out  STD_LOGIC);
	end component;

	component tempo_decoder is
		 Port ( tempo : in  STD_LOGIC_VECTOR (6 downto 0);
				  beat_len : out  STD_LOGIC_VECTOR (27 downto 0));
	end component;

	component semiq_counter is
		 Port ( clk : in std_logic;
					reset: in std_logic;
					en : in std_logic;
				 semi_len : in  STD_LOGIC_VECTOR (27 downto 0);
				  zero: out std_logic);
	end component;

	component ram is
		 Port ( clk : in  STD_LOGIC;
				 -- rst : in  STD_LOGIC;
				  wr_en : in STD_LOGIC;
				  addr : in  STD_LOGIC_VECTOR (9 downto 0);
				  data_in : in STD_LOGIC_VECTOR(7 downto 0);
				  data_out : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	component comparator is
		 Port ( char : in  STD_LOGIC_VECTOR (7 downto 0);
				  finish : out  STD_LOGIC);
	end component;
	
	component comparator2 is
		Port ( char : in  STD_LOGIC_VECTOR (7 downto 0);
           start : out  STD_LOGIC);
	end component;

	component bin_to_7seg is
		 Port ( digit : in  STD_LOGIC_VECTOR (3 downto 0);
				  disp_7seg : out  STD_LOGIC_VECTOR (6 downto 0));
	end component;

	component tempo_dig_breakdown is
		 Port (	tempo : in  STD_LOGIC_VECTOR (6 downto 0);
				  dig3 : out  STD_LOGIC_VECTOR (3 downto 0);
				  dig2 : out  STD_LOGIC_VECTOR (3 downto 0);
				  dig1 : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component seg_disp_clk_4ms is
		 Port ( clk : in  STD_LOGIC;
				  --rst : in  STD_LOGIC;
				  en : in  STD_LOGIC;
				  zero : out  STD_LOGIC);
	end component;

	component seg_disp_counter is
		 Port ( clk : in  STD_LOGIC;
				  rst : in  STD_LOGIC;
				  en : in STD_LOGIC;
				  cnt : out std_logic_vector(1 downto 0);
				  zero : out  STD_LOGIC);
	end component;

	component seg_disp_decoder is
		 Port ( rotation : in  STD_LOGIC_VECTOR (1 downto 0);
				  anode_enable : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component mux_3to1_4b is
		 Port ( sel : in  STD_LOGIC_VECTOR (1 downto 0);
				  x : in  STD_LOGIC_VECTOR (3 downto 0);
				  y : in  STD_LOGIC_VECTOR (3 downto 0);
				  z : in  STD_LOGIC_VECTOR (3 downto 0);
				  q : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component ram_addr_counter is
		port(clk : in std_logic;
				rst : in std_logic;
				en : in std_logic;
				addr_out : out std_logic_vector(9 downto 0));
	end component;
	
	component speaker_output is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
           spk_out : inout  STD_LOGIC);
	end component;

	component BUFG
		port (I : in STD_LOGIC;
				O : out STD_LOGIC);
	end component;
------------------------------------------------------------------------
-- Signals
------------------------------------------------------------------------
	signal char_in: std_logic_vector(7 downto 0) := "00000000";
	signal char_out: std_logic_vector(7 downto 0);
	
	--signal s_spk_rst : std_logic;
	
	signal s_isstart : std_logic;
	signal s_isend : std_logic;
	signal play_en : std_logic;
	
	signal s_tempo_hundr : std_logic_vector(3 downto 0);
	signal s_tempo_tens : std_logic_vector(3 downto 0);
	signal s_tempo_ones : std_logic_vector(3 downto 0);
	
	signal s_pitch_in : std_logic_vector(7 downto 0) := "00000000";
	signal s_len_in	: std_logic_vector(7 downto 0) := "00000000";
	signal s_tempo_in : std_logic_vector(6 downto 0); -- could vary, just add 0s
	
	signal s_fcount : std_logic_vector(18 downto 0); -- decoded frequency
	signal s_note_len : std_logic_vector(4 downto 0); -- decoded semiquaver multiples
	signal s_semiq_len : std_logic_Vector(27 downto 0); -- decoded tempo, semiq length
	signal s_freset : std_logic;	-- reset freq cnt	
	signal s_lreset : std_logic;	-- reset note length
	signal s_sreset : std_logic;
	signal s_freqfin : std_logic; -- freq count == 0
	signal s_semifin : std_logic; -- freq multiple/semiq == 0
	signal s_notefin: std_logic;	-- semiq multiple/note len == 0
	
	signal s_ramaddr_rst : std_logic;	
	signal s_ramaddr_nxt_en : std_logic;
	signal mem_addr: std_logic_vector(9 downto 0);	-- for ram addr counter
	
	signal s_ramwr_en : std_logic;	-- for ram
	
	--signal clkdiv: std_logic_vector(24 downto 0);
------------------------------------------------------------------------
-- signals for led display
------------------------------------------------------------------------
	signal s_anode : std_logic_vector(3 downto 0);
	signal s_curr_digit : std_logic_vector(3 downto 0); -- binary value for current digit  be displayed
	signal s_cathode : std_logic_vector(6 downto 0);
	
	signal s_disp_clk_en : std_logic;
	--signal s_disp_clk_rst : std_logic;
	signal s_disp_clk_zero : std_logic;
	signal s_disp_cntr_en : std_logic;
	signal s_disp_cntr_rst : std_logic;
	signal s_disp_cntr_cnt : std_logic_vector(1 downto 0);
	signal s_disp_cntr_zero : std_logic;
	
------------------------------------------------------------------------
-- State Machine Constant + Signal Declarations - Taken from Nexys Sample.
------------------------------------------------------------------------
-- The following constants define state codes for the EPP port interface
-- state machine. The high order bits of the state number give a unique
-- state identifier. The low order bits are the state machine outputs for
-- that state. This type of state machine implementation uses no
-- combination logic to generate outputs which should produce glitch
-- free outputs. 

	constant init		 : std_logic_vector(7 downto 0) := "0000" & "0000";
	constant stEppReady : std_logic_vector(7 downto 0) := "0001" & "0000";
	constant stEppAwrA : std_logic_vector(7 downto 0) := "0001" & "0100";
	constant stEppAwrB : std_logic_vector(7 downto 0) := "0010" & "0001";
	constant stEppArdA : std_logic_vector(7 downto 0) := "0011" & "0010";
	constant stEppArdB : std_logic_vector(7 downto 0) := "0100" & "0011";
	constant stEppDwrA : std_logic_vector(7 downto 0) := "0101" & "1000";
	constant stEppDwrB : std_logic_vector(7 downto 0) := "0110" & "0001";
	constant stEppDrdA : std_logic_vector(7 downto 0) := "0111" & "0010";
	constant stEppDrdB : std_logic_vector(7 downto 0) := "1000" & "0011";
	
	constant reset		 : std_logic_vector(7 downto 0) := "1001" & "0001";
	constant start		 : std_logic_vector(7 downto 0) := "1010" & "0001";
	constant	next_char : std_logic_vector(7 downto 0) := "1011" & "0001";
	constant len		 : std_logic_vector(7 downto 0) := "1100" & "0001";
	constant pitch		 : std_logic_vector(7 downto 0) := "1101" & "0001";
	constant play		 : std_logic_vector(7 downto 0) := "1110" & "0001";
	constant finish	 : std_logic_vector(7 downto 0) := "1111" & "0001";

	signal p_state: std_logic_vector(7 downto 0) := init;
	signal n_state : std_logic_vector(7 downto 0) := init;
	
--type state_type is (init, reset, start, next_char, len, pitch, play, finish);
--signal p_state, n_state : state_type;

-- Internal control signales
	signal ctlEppWait : std_logic;
	signal ctlEppAstb : std_logic;
	signal ctlEppDstb : std_logic;
	signal ctlEppDir : std_logic;
	signal ctlEppWr : std_logic;
	signal ctlEppAwr : std_logic;
	signal ctlEppDwr : std_logic;
	signal ctl_txt_end : std_logic;
	signal busEppOut : std_logic_vector(7 downto 0);
	signal busEppIn : std_logic_vector(7 downto 0);
	signal busEppData : std_logic_vector(7 downto 0);
	-- Registers
	signal regEppAdr : std_logic_vector(3 downto 0);
	signal regData0 : std_logic_vector(7 downto 0);
	signal regData1 : std_logic_vector(7 downto 0);
	signal regData2 : std_logic_vector(7 downto 0);
	signal regData3 : std_logic_vector(7 downto 0);
	signal regData4 : std_logic_vector(7 downto 0);
	signal regData5 : std_logic_vector(7 downto 0);
	signal regData6 : std_logic_vector(7 downto 0);
	signal regData7 : std_logic_vector(7 downto 0);

begin
------------------------------------------------------------------------
-- State Transition Logic
------------------------------------------------------------------------
FSM_TRANSITON:
	process(p_state, rst, s_isstart, s_isend, s_notefin, ctl_txt_end, ctlEppAstb, ctlEppWr, ctlEppDstb)
		begin					
				case p_state is
					when init =>
						n_state <= init;
						
					when reset =>
						if (rst = '0') then	-- if button is let go
							n_state <= stEppReady;	
						else						-- button still being held
							n_state <= reset;
						end if;
						--led_bufg(0) <= '0';
				
					-- Idle state waiting for the beginning of an EPP cycle
					when stEppReady =>
						if ctl_txt_end = '1' then
							n_state <= start;
							
						elsif ctlEppAstb = '0' then
					-- Address read or write cycle
							if ctlEppWr = '0' then
								n_state <= stEppAwrA;
							else
								n_state <= stEppArdA;
							end if;
						elsif ctlEppDstb = '0' then
					-- Data read or write cycle
							if ctlEppWr = '0' then
								n_state <= stEppDwrA;
							else
								n_state <= stEppDrdA;
							end if;
						else
							-- Remain in ready state
							n_state <= stEppReady;
						end if;
					-- Write address register
					when stEppAwrA =>
						n_state <= stEppAwrB;
					when stEppAwrB =>
						if ctlEppAstb = '0' then
							n_state <= stEppAwrB;
						else
							n_state <= stEppReady;
						end if;
					-- Read address register
					when stEppArdA =>
						n_state <= stEppArdB;
					when stEppArdB =>
						if ctlEppAstb = '0' then
							n_state <= stEppArdB;
						else
							n_state <= stEppReady;
					end if;
					-- Write data register
					when stEppDwrA =>
						n_state <= stEppDwrB;
					when stEppDwrB =>
						if ctlEppDstb = '0' then
							n_state <= stEppDwrB;
						else
							n_state <= stEppReady;
						end if;
					-- Read data register
					when stEppDrdA =>
						n_state <= stEppDrdB;
					when stEppDrdB =>
						if ctlEppDstb = '0' then
							n_state <= stEppDrdB;
					else
							n_state <= stEppReady;
					end if;				

					when start => 
						if (s_isstart = '1') then -- check 60<= char <= 120 if bothered, else just assume correct input
							n_state <= next_char;	-- <
						else
							n_state <= start;
						end if;
					when next_char =>	
						if s_isend = '1' then -- @
							n_state <= finish;
						else
							n_state <= pitch;
						end if;
						
					when pitch =>			
							n_state <= len;
						
					when len =>
						n_state <= play;				

					when play =>
						if (s_notefin = '1') then
							n_state <= next_char;
						else
							n_state <= play;
						end if;						
					when finish =>
						n_state <= finish;
						
					when others => 	--unknown state
						n_state <= init;
						--led_bufg(0) <= '1';

				end case;
		end process;
	
	process(clk)
		begin
			if falling_edge(clk) then			
				if (rst = '1') then		-- push button pushed
					p_state <= reset;
				else
					p_state <= n_state;
				end if;
			end if;
	end process;
	
	led(0) <= '1' when p_state = reset else '0';
	led(1) <= '1' when p_state = stEppReady else '0';
	led(7) <= '1' when p_state = play else '0';
	led(6) <= '1' when p_state = start else '0';
	led(5 downto 2) <= "0000";
------------------------------------------------------------------------
-- Control Signals
------------------------------------------------------------------------

EPP_CONTROL:

	-- Decode the address register and select the appropriate data register
	busEppData <= regData0 when regEppAdr = "0000" else
						regData1 when regEppAdr = "0001" else
						regData2 when regEppAdr = "0010" else
						regData3 when regEppAdr = "0011" else
						regData4 when regEppAdr = "0100" else
						regData5 when regEppAdr = "0101" else
						regData6 when regEppAdr = "0110" else
						regData7 when regEppAdr = "0111" else
					--	rgSwt when regEppAdr = "1000" else
					--	"000" & rgBtn when regEppAdr = "1001" else
						"00000000";
	-- Map control signals from the current state
	ctlEppWait <= p_state(0);
	ctlEppDir <= p_state(1);
	ctlEppAwr <= p_state(2);
	ctlEppDwr <= p_state(3);

	ctlEppAstb <= astb;
	ctlEppDstb <= dstb;
	ctlEppWr <= pwr;
	pwait <= ctlEppWait; -- drive WAIT from state machine output
	-- Data bus direction control. The internal input data bus always
	-- gets the port data bus. The port data bus drives the internal
	-- output data bus onto the pins when the interface says we are doing
	-- a read cycle and we are in one of the read cycles states in the
	-- state machine.
	busEppIn <= pdb;
	pdb <= busEppOut when ctlEppWr = '1' and ctlEppDir = '1' else "ZZZZZZZZ";
	-- Select either address or data onto the internal output data bus.
	busEppOut <= "0000" & regEppAdr when ctlEppAstb = '0' else busEppData;

	------------------------------------------------------------------------
	-- LCD display
	------------------------------------------------------------------------

	--s_disp_clk_rst <= '1' when p_state = init or p_state = reset else s_disp_clk_zero;
	--bufg_disp_clk_zero: bufg port map (s_disp_clk_zero_bufg, s_disp_clk_zero);
	--s_disp_cntr_rst <= '1' when p_state = init or p_state = reset else s_disp_cntr_zero;
	
	--s_disp_clk_en <= '0' when p_state = init or p_state = reset else '1';
	--s_disp_cntr_en <= '0' when p_state = init or p_state = reset else '1';
	
	-----------------------------------------------------------------------------	
	
	--ctl_txt_end <= '1' when char_in = "01000000" else '0'; -- @	
	
	--	char_in <= busEppIn when s_ramwr_en = '1';		
	--	s_ramwr_en_bufg <= '1' when p_state = stEppDwrB and ctlEppDstb = '1' else '0';
	--bufg_ramwr_en : BUFG port map (s_ramwr_en_bufg, s_ramwr_en);
		
		--s_ramaddr_rst <= '1' when rst = '1' else
								--'1' when p_state = stEppReady and n_state = start else -- try p_state if resets too early
								--'0';
--	s_ramaddr_nxt_en <= '1' when p_state = stEppDwrB and ctlEppDstb = '1' else
--								'1' when p_state = start else
--								'1' when n_state = next_char else 
--								'1' when n_state = pitch else '0';
								
	--s_tempo_in <= char_out(6 downto 0) when p_state = start and s_isstart = '1';--"0111100";
	s_tempo_in <= "0111100";
	--play_en <= '1' when n_state = play else '0';
	--s_freset_bufg <= '1' when p_state = pitch or s_freqfin = '1' else '0';
--bufg_sfreset : BUFG port map(s_freset_bufg, s_freset);
	--s_lreset <= '1' when p_state = len else '0';
	--s_sreset <= '1' when n_state = len or (s_notefin = '0' and s_semifin = '1') else '0'; --change to tempo later

------------------------------------------------------------------------
-- CONTROL CIRCUIT + OUTPUTS
------------------------------------------------------------------------

FSM_OUTPUTS:
	process(p_state, n_state, s_isstart, s_isend, char_out, s_freqfin, ctlEppDstB, busEppIn, ctl_txt_end, s_notefin, s_semifin, s_disp_clk_zero, s_disp_cntr_zero)
	begin
	
		s_disp_clk_en <= '1';
		s_disp_cntr_en <= '1';
		
		s_ramwr_en <= '0';
		s_ramaddr_rst <= '0';
		s_ramaddr_nxt_en <= '0';
		play_en <= '0';
		s_freset <= '0';
		s_lreset <= '0';
		s_sreset <= '0';
		case p_state is
			when init =>
				s_disp_cntr_rst <= '1';
				s_disp_clk_en <= '0';
				s_disp_cntr_en <= '0';
			when reset =>
				s_disp_cntr_rst <= '1';
				s_disp_clk_en <= '0';
				s_disp_cntr_en <= '0';
				s_ramaddr_rst <= '1';
			when stEppReady =>			
				s_disp_cntr_rst <= s_disp_cntr_zero;
				if ctl_txt_end = '1' then
					s_ramaddr_rst <= '1';
				end if;
			when stEppDwrB =>				
				s_disp_cntr_rst <= s_disp_cntr_zero;
				if ctlEppDstB = '1' then
					s_ramwr_en <= '1';
					s_ramaddr_nxt_en <= '1';
				end if;
			when start =>				
				s_disp_cntr_rst <= s_disp_cntr_zero;
				if (s_isstart = '0') then
					s_ramaddr_nxt_en <= '1';
				else
					s_ramaddr_nxt_en <= '0';
				end if;
			when next_char =>				
				s_disp_cntr_rst <= s_disp_cntr_zero;				
				--s_ramaddr_nxt_en <= '1';
			when pitch =>			
				s_disp_cntr_rst <= s_disp_cntr_zero;
				s_ramaddr_nxt_en <= '1';				
				s_freset <= '1';
				s_sreset <= '1';
			when len =>				
				s_disp_cntr_rst <= s_disp_cntr_zero;				
				--s_ramaddr_nxt_en <= '1';
				s_lreset <= '1';
			when play =>					
				s_disp_cntr_rst <= s_disp_cntr_zero;
				if s_notefin = '0' then
					play_en <= '1';
				end if;
				if s_freqfin = '1' then			
					s_freset <= '1';
				end if;
				if (s_notefin = '0' and s_semifin = '1') then
					s_sreset <= '1';
				end if;
				if (n_state = next_char) then
					s_ramaddr_nxt_en <= '1';
				end if;
			when finish =>			
				s_disp_cntr_rst <= s_disp_cntr_zero;
			when others =>				
				s_disp_cntr_rst <= s_disp_cntr_zero;				
		end case;	
	end process;
	
	process(clk, p_state, s_freqfin)
	begin
		if falling_Edge(clk) then
			if p_State = play then
				 if s_freqfin = '1' then
					spk <= not spk;
				end if;
			else
				spk <= '0';
			end if;
		end if;
	end process;
	
------------------------------------------------------------------------
-- DATAPATH FOR MUSICPLAYER
------------------------------------------------------------------------
--FSM_DATAPATH:
--	process(p_state, s_freset, ctlEppDstB, busEppIn, char_out)
--	begin
--		case p_state is
--			when stEppDwrB =>
--				if ctlEppDstB = '1' then
--					char_in <= busEppIn;
--				end if;
--			when next_char =>		
--				s_pitch_in <= char_out;
--			when len =>					
--				s_len_in <= char_out;	
--			when others =>			
--		end case;	
--	end process;
	
process(clk, p_state, ctlEppDstB)
	begin
		if falling_edge(clk) then
			if p_state = stEppDwrB and ctlEppDstB = '1' then
				char_in <= busEppIn;
			end if;
		end if;
	end process;
		
process(clk, n_state, char_out)
	begin
		if falling_edge(clk) then
			if n_state = next_char then
				s_pitch_in <= char_out;
			end if;
		end if;
	end process;
		
process(clk, n_state)
	begin
		if falling_edge(clk) then
			if n_state = len then
				s_len_in <= char_out;
			end if;
		end if;
	end process;
	
	-------------------------------------lcd--------------------------------------------
	get_tempo_digits: 			tempo_dig_breakdown port map(s_tempo_in, s_tempo_hundr, s_tempo_tens, s_tempo_ones);
	dig_to_7seg : 					bin_to_7seg port map(s_curr_digit, s_cathode);
	disp_4ms_count: 				seg_disp_clk_4ms port map(clk, s_disp_clk_en, s_disp_clk_zero);
	disp_anode_rotation: 		seg_disp_counter port map(s_disp_clk_zero, s_disp_cntr_rst, s_disp_cntr_en, s_disp_cntr_cnt, s_disp_cntr_zero);
	decode_to_anode : 			seg_disp_decoder port map(s_disp_cntr_cnt, s_anode);	-- produces anode mask
	select_digit_to_display : 	mux_3to1_4b port map(s_disp_cntr_cnt, s_tempo_hundr, s_tempo_tens, s_tempo_ones, s_curr_digit);
	disp <= s_anode;
	seg <= s_cathode;
		
	------------------------------------ram---------------------------------------------
	addr_count: 			ram_addr_counter port map(clk, s_ramaddr_rst, s_ramaddr_nxt_en, mem_addr);	
	read_and_write_data: ram port map(clk, s_ramwr_en, mem_addr, char_in, char_out);
	
		
	------------------------------------musicplayer-------------------------------------
	get_frequency: freq_decoder port map(s_pitch_in, s_fcount);
	set_output_freq: freq_counter port map(clk, s_freset, play_en, s_fcount, s_freqfin);	-- count pitch oscillation
	
	get_note_len: note_len_decoder port map(s_len_in, s_note_len);
	set_semiq_multiple: note_len_counter port map(clk, s_lreset, s_semifin, s_note_len, s_notefin);	-- count down per semiq in note
	
	get_tempo: tempo_decoder port map(s_tempo_in, s_semiq_len);
	set_semiq_len : semiq_counter port map(clk, s_sreset, play_en, s_semiq_len, s_semifin);	-- count len of semiq
	
	
	--check_read_start:				comparator2 port map(char_out, s_isstart);
	s_isstart <= '0' when char_out = "00000000" else '1';
	check_write_finish:			comparator port map(char_in, ctl_txt_end);
	check_read_finish: 			comparator port map(char_out, s_isend);
	--speaker : speaker_output port map(clk, s_spk_rst, play_en, spk);

------------------------------------------------------------------------
-- EPP Data registers
------------------------------------------------------------------------
-- The following processes implement the interface registers. These
-- registers just hold the value written so that it can be read back.
-- In a real design, the contents of these registers would drive additional
-- logic.
-- The ctlEppDwr signal is an output from the state machine that says
-- we are in a 'write data register' state. This is combined with the
-- address in the address register to determine which register to write.
	process (clk, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if falling_edge(clk) then
				if ctlEppDwr = '1' and regEppAdr = "0000" then
					regData0 <= busEppIn;
				end if;
			end if;
	end process;

	process (clk, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if falling_edge(clk) then
				if ctlEppDwr = '1' and regEppAdr = "0001" then
					regData1 <= busEppIn;
				end if;
			end if;
	end process;

	process (clk, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if falling_edge(clk) then
				if ctlEppDwr = '1' and regEppAdr = "0010" then
					regData2 <= busEppIn;
				end if;
			end if;
	end process;

	process (clk, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if falling_edge(clk) then
				if ctlEppDwr = '1' and regEppAdr = "0011" then
					regData3 <= busEppIn;
				end if;
			end if;
	end process;

	process (clk, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if falling_edge(clk) then
				if ctlEppDwr = '1' and regEppAdr = "0100" then
					regData4 <= busEppIn;
				end if;
			end if;
	end process;

	process (clk, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if falling_edge(clk) then
				if ctlEppDwr = '1' and regEppAdr = "0101" then
					regData5 <= busEppIn;
				end if;
			end if;
	end process;

	process (clk, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if falling_edge(clk) then
				if ctlEppDwr = '1' and regEppAdr = "0110" then
					regData6 <= busEppIn;
				end if;
			end if;
	end process;

	process (clk, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if falling_edge(clk) then
				if ctlEppDwr = '1' and regEppAdr = "0111" then
					regData7 <= busEppIn;
				end if;
			end if;
			
	end process;

	process (clk, regEppAdr, ctlEppDwr, busEppIn)
		begin
			if falling_edge(clk) then
				if ctlEppDwr = '1' and regEppAdr = "1010" then
					--regLed <= busEppIn;
				end if;
			end if;
	end process;
end Behavioral;

