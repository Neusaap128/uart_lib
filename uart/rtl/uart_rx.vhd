library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


package uart_rx_pkg_e is

    component uart_rx
        port (    
          clk             : in   std_logic;
          rst_async       : in   std_logic;
    
          -- line
          rx_in             :  in std_logic;
    
          -- data
          rx_data_out           : out std_logic_vector(7 downto 0) ;
          rx_data_valid_out     : out std_logic;
          rx_framing_error_out  : out std_logic;

          -- config
          baud_div_in  : in std_logic_vector(15 downto 0);

          -- status
          rx_ready_out  : out  std_logic

        );
    end component;

end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity uart_rx is
    Port (
      clk             : in   std_logic;
      rst_async       : in   std_logic;
  
      -- line
      rx_in             :  in std_logic;
  
      -- data
      rx_data_out           : out std_logic_vector(7 downto 0) ;
      rx_data_valid_out     : out std_logic;
      rx_framing_error_out  : out std_logic;

      -- config
      baud_div_in  : in std_logic_vector(15 downto 0);

      -- status
      rx_ready_out  : out  std_logic
    );
end uart_rx;

architecture Behavioral of uart_rx is

  signal s_baud_counter : integer range 0 to 2**16-1;

  signal s_read : std_logic;

  signal rx_in_d : std_logic;
  signal rx_falling_edge : std_logic;

  -- includes start and stop bit
  signal s_bit_counter : integer range 0 to 8;
  
  signal rx_ready : std_logic;
  signal rx_reading : std_logic;


begin

  rx_ready_out <= rx_ready;

  rx_falling_edge <= rx_in_d and not rx_in;

  process(clk, rst_async)
  begin

    if(rst_async = '0') then

      s_bit_counter <= 0;
      rx_data_out <= (others => '0');
      rx_data_valid_out <= '0';
      rx_framing_error_out <= '0';

    elsif(clk'event and clk = '1') then

      rx_framing_error_out <= '0';
      rx_data_valid_out <= '0';

      if(s_read = '1') then

        if(s_bit_counter = 8) then
          s_bit_counter <= 0;
        else 
          s_bit_counter <= s_bit_counter + 1;
        end if;

        if(s_bit_counter < 8) then
            rx_data_out(s_bit_counter) <= rx_in;
        end if;
        
        if(s_bit_counter = 8) then

          if(rx_in  = '1') then
            rx_data_valid_out <= '1';
          else
            rx_framing_error_out <= '1';
          end if;

        end if;

      end if;

    end if;

  end process;


  -- baud divider  
  process(clk, rst_async)
  begin

    if(rst_async = '0') then

      s_baud_counter <= 0;
      s_read <= '0';
    
      rx_ready <= '1';
      rx_reading <= '0';

      rx_in_d <= '0';

    elsif(clk'event and clk = '1') then

      
      s_read <= '0';
      rx_in_d <= rx_in;  


      if(rx_falling_edge = '1' and rx_ready = '1') then

        s_baud_counter <= to_integer(unsigned(baud_div_in)) + to_integer(unsigned(baud_div_in(15 downto 1))) -1;
        rx_reading <= '1';
        rx_ready <= '0';
      end if;


      if(rx_reading = '1') then

        if(s_baud_counter = 0) then

          s_baud_counter <= to_integer(unsigned(baud_div_in))-1;

          s_read <= '1';

          if(s_bit_counter = 8) then
            rx_reading <= '0';
            rx_ready <= '1';
          end if;
  
        else
          s_baud_counter <= s_baud_counter -1;
        end if;

      end if;
    
    end if;

  end process;

  

end Behavioral;





