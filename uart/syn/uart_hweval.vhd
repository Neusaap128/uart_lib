
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library uart_lib;
use uart_lib.uart_tx_pkg_e.all;

entity uart_hweval is
    Port (
        clk             : in   std_logic;
        rst_async       : in   std_logic;
    
        -- lines
        tx_out          : out std_logic;
        rx_in           :  in std_logic;
      
        output          : out std_logic
    );
end uart_hweval;

architecture Behavioral of uart_hweval is

  signal tx_data       : std_logic_vector(7 downto 0);
  signal tx_data_valid : std_logic;
  signal rx_data       : std_logic_vector(7 downto 0);
  signal rx_data_valid : std_logic;
  signal rx_framing_error : std_logic;

  signal baud_div : std_logic_vector(15 downto 0);

  signal tx_ready : std_logic;

  signal state : integer range 0 to 2;

begin

    uart_i : entity uart_lib.uart
    port map (
        clk             => clk,
        rst_async       => rst_async,
   
        -- lines
        tx_out            => tx_out,
        rx_in             => rx_in,
   
        -- data
        tx_data_in        => tx_data,
        tx_data_valid_in  => tx_data_valid,
   
        rx_data_out       => rx_data,
        rx_data_valid_out => rx_data_valid,
        rx_framing_error_out => rx_framing_error,

        -- config
        --max baud rate:
        baud_div_in       => baud_div, 
   
        -- status
        tx_ready_out      => tx_ready,
        rx_ready_out      => open
    );

    process(clk, rst_async)
    begin

      if(rst_async = '0') then

        tx_data <= x"00";
        tx_data_valid <= '0';
        state <= 0;
        baud_div <= std_logic_vector(to_unsigned(868, 16));

      elsif(clk'event and clk = '1') then

        tx_data_valid <= '0';
          
        if(tx_ready = '1') then
          tx_data_valid <= '1';

          case(state) is

            when 0 =>
              baud_div <= std_logic_vector(to_unsigned(868, 16));   -- 115200
              tx_data <= x"AA";
              state <= 1;
            when 1 =>
              baud_div <= std_logic_vector(to_unsigned(10417, 16)); -- 9600
              tx_data <= x"32";
              state <= 2;
            when 2 =>
              baud_div <= std_logic_vector(to_unsigned(10417, 16)); -- 9600
              tx_data <= x"C9";
              state <= 0;

          end case;

        end if;
        
       if(rx_data_valid = '1' or rx_framing_error = '1') then
          output <= rx_data(2) xor rx_data(5) xor rx_data(7);
       end if;

      end if;

    end process;




end Behavioral;





