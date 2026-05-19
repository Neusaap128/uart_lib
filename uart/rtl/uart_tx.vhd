library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


package uart_tx_pkg_e is

    component uart_tx
        port (    
          clk             : in   std_logic;
          rst_async       : in   std_logic;
    
          -- line
          tx_out            : out std_logic;
    
          -- data
          tx_data_in        :  in std_logic_vector(7 downto 0) ;
          tx_data_valid_in  :  in std_logic;

          -- config
          --max baud rate: 
          baud_div_in  : in std_logic_vector(15 downto 0);

          -- status
          tx_ready_out  : out  std_logic

        );
    end component;

end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity uart_tx is
    Port (
        clk             : in   std_logic;
        rst_async       : in   std_logic;
    
        -- line
        tx_out            : out std_logic;
    
        -- data
        tx_data_in        :  in std_logic_vector(7 downto 0) ;
        tx_data_valid_in  :  in std_logic;
        
        -- config
        --max baud rate: 
        baud_div_in  : in std_logic_vector(15 downto 0);

        -- status
        tx_ready_out  : out  std_logic

    );
end uart_tx;

architecture Behavioral of uart_tx is

  signal s_baud_counter : integer range 0 to 2**16-1;

  signal s_transfer : std_logic;

  -- includes start and stop bit
  signal s_bit_counter : integer range 0 to 9;
  
  signal tx_ready : std_logic;
  signal tx_transmitting : std_logic;
  signal tx_transmitting_stop_bit : std_logic;
  signal tx_data_buff : std_logic_vector(7 downto 0);

begin


  tx_ready <= not tx_transmitting;
  tx_ready_out <= tx_ready; 


  process(clk, rst_async)
  begin

    if(rst_async = '0') then

      s_bit_counter <= 0;
      tx_out <= '1';

    elsif(clk'event and clk = '1') then

      if(s_transfer = '1') then

        if(s_bit_counter = 9) then
          s_bit_counter <= 0;
        else 
          s_bit_counter <= s_bit_counter + 1;
        end if;

        case s_bit_counter is

          when 0 =>
              tx_out <= '0';
          when 1 to 8 =>
              tx_out <= tx_data_buff(s_bit_counter - 1);
          when 9 =>
              tx_out <= '1';
          when others =>
              tx_out <= '1';

        end case;

      end if;

    end if;

  end process;


  -- baud divider  
  process(clk, rst_async)
  begin

    if(rst_async = '0') then

      s_baud_counter <= 0;
      s_transfer <= '0';
      tx_transmitting <= '0';
      tx_transmitting_stop_bit <= '0';

      tx_data_buff <= (others => '0');

    elsif(clk'event and clk = '1') then

      
      s_transfer <= '0';

      if(tx_data_valid_in = '1' and tx_ready = '1') then
        tx_data_buff <= tx_data_in;
        tx_transmitting <= '1';
      end if;

      if(tx_transmitting = '1') then

        if(s_baud_counter = 0) then

          s_baud_counter <= to_integer(unsigned(baud_div_in))-1;

          if(s_bit_counter = 9) then
            tx_transmitting_stop_bit <= '1';
          end if;
          
          if(tx_transmitting_stop_bit = '1') then
            tx_transmitting <= '0';
            tx_transmitting_stop_bit <= '0';
          else
            s_transfer <= '1';
          end if;
  
        else
          s_baud_counter <= s_baud_counter -1;
        end if;

      end if;
    
    end if;

  end process;

  

end Behavioral;





