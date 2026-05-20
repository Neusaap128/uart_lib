library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


package uart_pkg_e is

    component uart
        port (    
          clk             : in   std_logic;
          rst_async       : in   std_logic;
    
          -- lines
          tx_out            : out std_logic;
          rx_in             :  in std_logic;
    
          -- data
          tx_data_in        :  in std_logic_vector(7 downto 0) ;
          tx_data_valid_in  :  in std_logic;

          rx_data_out       : out std_logic;
          rx_data_valid_out : out std_logic;
          rx_framing_error_out  : out std_logic;
          
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

library uart_lib;
use uart_lib.uart_tx_pkg_e.all;

entity uart is
    Port (
        clk             : in   std_logic;
        rst_async       : in   std_logic;
    
        -- lines
        tx_out            : out std_logic;
        rx_in             :  in std_logic;
    
        -- data
        tx_data_in        :  in std_logic_vector(7 downto 0);
        tx_data_valid_in  :  in std_logic;

        rx_data_out       : out std_logic_vector(7 downto 0);
        rx_data_valid_out : out std_logic;
        rx_framing_error_out  : out std_logic;
        
        -- config
        --max baud rate: 
        baud_div_in  : in std_logic_vector(15 downto 0);

        -- status
        tx_ready_out  : out  std_logic;
        rx_ready_out  : out  std_logic

    );
end uart;

architecture Behavioral of uart is
begin



    uart_tx_i : entity uart_lib.uart_tx
    port map (
      clk             => clk,
      rst_async       => rst_async,
   
      -- lines
      tx_out            => tx_out,
   
      -- data
      tx_data_in        => tx_data_in,
      tx_data_valid_in  => tx_data_valid_in,
  
      -- config
      baud_div_in       => baud_div_in, 
   
      -- status
      tx_ready_out      => tx_ready_out
    );                                



    uart_rx_i : entity uart_lib.uart_rx
    port map (
      clk             => clk,
      rst_async       => rst_async,
 
      -- lines
      rx_in            => rx_in,
 
      -- data
      rx_data_out           => rx_data_out,
      rx_data_valid_out     => rx_data_valid_out,
      rx_framing_error_out  => rx_framing_error_out,

 
      -- config
      baud_div_in       => baud_div_in,
 
      -- status
      rx_ready_out      => rx_ready_out
    );



end Behavioral;





