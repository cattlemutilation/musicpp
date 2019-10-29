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
--library UNISIM;
--use UNISIM.VComponents.all;

entity musicplayer is
    Port ( clk : in  STD_LOGIC;
				rst : in std_logic;
			  addr : out std_Logic_Vector(22 downto 0);	-- don't need for now, interface with ram
			  swt : in std_Logic_vector(7 downto 0);
			  led : out std_logic_Vector(7 downto 0);
			  disp : out std_logic_vector(3 downto 0);	-- which led is lit
			  seg : out std_logic_vector(6 downto 0);		-- which segments of 7seg display are lit
           spk : inout  STD_LOGIC);
end musicplayer;

architecture Behavioral of musicplayer is
--------------------------------components------------------------------------

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

component addr_counter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  en : in std_logic;
           addr_out : out  STD_LOGIC_VECTOR (10 downto 0));
end component;

component rom is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (10 downto 0);
           data : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component comparator is
    Port ( char : in  STD_LOGIC_VECTOR (7 downto 0);
           start : out  STD_LOGIC;
           finish : out  STD_LOGIC);
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
           rst : in  STD_LOGIC;
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

-------------------------------end components-----------------------------------
--------------------------------------------------------------------------------

-----------------------------------------------------------------------------
---------------------------------signals-------------------------------------
	signal note: std_logic;
	signal one: std_logic;
	signal char: std_logic_vector(7 downto 0);
	signal mem_addr: std_logic_vector(10 downto 0);
	signal next_addr_en : std_logic;
	
	signal s_isstart : std_logic;
	signal s_isend : std_logic;
	signal play_en : std_logic;
	signal testing : std_logic;
	
	signal s_tempo_hundr : std_logic_vector(3 downto 0);
	signal s_tempo_tens : std_logic_vector(3 downto 0);
	signal s_tempo_ones : std_logic_vector(3 downto 0);
	
	signal s_pitch_in : std_logic_vector(7 downto 0);
	signal s_len_in	: std_logic_vector(7 downto 0);
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
	signal s_songfin : std_logic;	-- finish state
	
	signal clkdiv: std_logic_vector(24 downto 0);
	
	----------------signals for led display------------------------
	signal s_anode : std_logic_vector(3 downto 0);
	signal s_curr_digit : std_logic_vector(3 downto 0); -- binary value for current digit  be displayed
	signal s_cathode : std_logic_vector(6 downto 0);
	
	signal s_disp_clk_en : std_logic;
	signal s_disp_clk_rst : std_logic;
	signal s_disp_clk_zero : std_logic;
	signal s_disp_cntr_en : std_logic;
	signal s_disp_cntr_rst : std_logic;
	signal s_disp_cntr_cnt : std_logic_vector(1 downto 0);
	signal s_disp_cntr_zero : std_logic;
	
	type state_type is (init, reset, start, next_char, len, pitch, play, finish);
	signal p_state, n_state : state_type;
--------------------------------- end signals----------------------------------
-------------------------------------------------------------------------------
begin
	one <= '1';
	process (clk)
		begin
			if clk = '0' and clk'Event then
				clkdiv <= clkdiv + 1;
			end if;
		end process;
		
check_start_finish: comparator port map(char, s_isstart, s_isend);

------------------------------------------------------------------------------
-------------------------state transition logic-------------------------------		
FSM_TRANSITON:
	process(p_state, rst, s_isstart, s_isend, s_notefin, s_songfin)
		begin
				case p_state is
					when init =>
							n_state <= init;
					when reset =>
						if (rst = '0') then	-- if button is let go
							n_state <= start;	
						else						-- button still being held
							n_state <= reset;
						end if;
					when start => 
						if (s_isstart = '1') then -- 60
							n_state <= next_char;	-- <
						else
							n_state <= start;
						end if;
					when next_char =>
						if s_isend = '1' then -- @
							n_state <= finish;
						else
							n_state <= len;
						end if;
					when len =>
						n_state <= pitch;
						
					when pitch =>
						n_state <= play;
					
					when play =>
						if (s_notefin = '1') then
							n_state <= next_char;
						else
							n_state <= play;
						end if;
						
					when finish =>
						n_state <= finish;
				end case;
		end process;
	
	process(clk, rst)
		begin
			if (rst = '1') then		-- push button pushed
				p_state <= reset;
			elsif (clk'event and clk = '0') then
				p_state <= n_state;
			end if;
		end process;
	
-------------------------------------------------------------------------------------
------------------------------------------control signals----------------------------
FSM_CONTROL:
	s_tempo_in <= "1111000";
	s_songfin <= '1' when p_state = finish else '0';
	
	next_addr_en <= '1' when n_state = next_char else
						'1' when n_state = pitch else
						'1' when n_state = start else '0';
	play_en <= '1' when n_state = play else '0';
	s_freset <= '1' when p_state = pitch or s_freqfin = '1' else '0';
	s_lreset <= '1' when p_state = len else '0';
	s_sreset <= '1' when n_state = len or (s_notefin = '0' and s_semifin = '1') else '0'; --change to tempo later
	
	-------------------led display control signals-------------------------------
	s_disp_clk_rst <= '1' when p_state = init or p_state = reset else s_disp_clk_zero;
	s_disp_cntr_rst <= '1' when p_state = init or p_state = reset else s_disp_cntr_zero;
	
	s_disp_clk_en <= '0' when p_state = init or p_state = reset else '1';
	s_disp_cntr_en <= '0' when p_state = init or p_state = reset else '1';
	-----------------------------------------------------------------------------
	
	
	next_data_addr: addr_counter port map(clk, rst, next_addr_en, mem_addr);	-- count up to next addr
	read_data: rom port map(clk, rst, mem_addr, char);	

	get_frequency: freq_decoder port map(s_pitch_in, s_fcount);
	set_output_freq: freq_counter port map(clk, s_freset, play_en, s_fcount, s_freqfin);	-- count pitch oscillation
	
	get_note_len: note_len_decoder port map(s_len_in, s_note_len);
	set_semiq_multiple: note_len_counter port map(clk, s_lreset, s_semifin, s_note_len, s_notefin);	-- count down per semiq in note
	
	get_tempo: tempo_decoder port map(s_tempo_in, s_semiq_len);
	set_semiq_len : semiq_counter port map(clk, s_sreset, play_en, s_semiq_len, s_semifin);	-- count len of semiq

----------------------------------------------------------------
------------------------datapth---------------------------------
FSM_DATAPATH:
	process(p_state, s_freset)
	begin
		case p_state is
			when start => 
				s_songfin <= '0';
				spk <= '0';
				note <= '0';
			when next_char =>
				spk <= '0';
				note <= '0';
				s_len_in <= char;
			when pitch =>		
				spk <= '0';
				s_pitch_in <= char;
			when play =>	
				if(s_freset = '1') then
					spk <= not spk;
				end if;
			when finish =>
				spk <= '0';
				note <= '0';
				s_songfin <= '1';
			when others =>
				spk <= '0';
				note <= '0';
		end case;	
	end process;

	led <= swt;	
	
----display
get_tempo_digits: 			tempo_dig_breakdown port map(s_tempo_in, s_tempo_hundr, s_tempo_tens, s_tempo_ones);
dig_to_7seg : 					bin_to_7seg port map(s_curr_digit, s_cathode);
disp_4ms_count: 				seg_disp_clk_4ms port map(clk, s_disp_clk_rst, s_disp_clk_en, s_disp_clk_zero);
disp_anode_rotation: 		seg_disp_counter port map(s_disp_clk_zero, s_disp_cntr_rst, s_disp_cntr_en, s_disp_cntr_cnt, s_disp_cntr_zero);
decode_to_anode : 			seg_disp_decoder port map(s_disp_cntr_cnt, s_anode);	-- produces anode mask
select_digit_to_display : 	mux_3to1_4b port map(s_disp_cntr_cnt, s_tempo_hundr, s_tempo_tens, s_tempo_ones, s_curr_digit);

disp <= s_anode;
seg <= s_cathode;--s_cathode;

--------------------------end display---------------------------
----------------------------------------------------------------
end Behavioral;

