library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library uart_lib;
use uart_lib.uart_pkg_e.all;

entity tb_uart is
end tb_uart;


architecture test of tb_uart is

    signal clk          : std_logic := '0';
    signal rst_async    : std_logic := '0';


    signal tx_data        : std_logic_vector(7 downto 0);
    signal tx_data_valid  : std_logic;


begin


    dut : entity uart_lib.uart
    port map (
        clk             => clk,
        rst_async       => rst_async,
   
        -- lines
        tx_out            => open,
        rx_in             => '1',
   
        -- data
        tx_data_in        => tx_data,
        tx_data_valid_in  => tx_data_valid,
   
        rx_data_out       => open,
        rx_data_valid_out => open,
   
        -- config
        --max baud rate:
        baud_div_in       => std_logic_vector(to_unsigned(868, 16)),
   
        -- status
        tx_ready_out      => open

    );                                
                                      
                                      
    clk_process : process             
    begin                             
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;


    -- Stimulus process
    stim_proc: process
    begin

        wait for 20 ns;

        rst_async <= '0';   
        tx_data <= "01000001";
        tx_data_valid <= '0';


        wait for 20 ns;

        rst_async <= '1';   
        wait for 20 ns; 

        wait for 10 us; 

        tx_data_valid <= '1';
        wait until clk'event and clk = '1';
        tx_data_valid <= '0';
        wait until clk'event and clk = '1';



        wait for 100 us; 
        wait until clk'event and clk = '1';


        assert false
          report "Simulation finished"
          severity failure;

        wait; -- stop simulation

    end process;


end test;

