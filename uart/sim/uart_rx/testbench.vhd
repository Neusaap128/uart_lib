library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

library uart_lib;
use uart_lib.uart_pkg_e.all;

entity tb_uart_rx is
end tb_uart_rx;


architecture test of tb_uart_rx is

    signal clk          : std_logic := '0';
    signal rst_async    : std_logic := '0';

    signal rx_data        : std_logic_vector(7 downto 0);
    signal rx_data_valid  : std_logic;

    signal rx : std_logic;

    signal tx_start        : std_logic;
    signal tx_active       : std_logic;
    signal tx_data         : std_logic_vector(7 downto 0);
    signal tx_baud_counter : integer range 0 to 868;
    signal tx_bit_counter  : integer range -1 to 9; -- start and stop bit

    file log_file : text open write_mode is "../res/tb_res.log";

    constant c_amount_of_tests : integer := 16;
    type t_test_vector_array is array (0 to c_amount_of_tests - 1 ) of std_logic_vector(7 downto 0);

    constant test_vectors : t_test_vector_array := (
        x"00",
        x"FF",
        x"55",
        x"AA",
        x"0F",
        x"F0",
        x"81",
        x"7E",
        x"01",
        x"80",
        x"42",
        x"24",
        x"18",
        x"C3",
        x"5A",
        x"A5"
    );

     procedure unit_test(
        variable l        : inout line;
        signal tx_data    : out std_logic_vector(7 downto 0);
        signal tx_start   : out std_logic;
        constant data     : in std_logic_vector(7 downto 0)
    ) is
    begin

        write(l, string'("----- TEST -----"));
        writeline(log_file, l);

        write(l, string'("data byte; 0x") );
        hwrite(l, data);
        writeline(log_file, l);


        tx_data  <= data;
        tx_start <= '1';

        wait until rising_edge(clk);

        tx_start <= '0';

        wait until rx_data_valid = '1';
        wait until rising_edge(clk);


        if rx_data = data then
            write(l, string'("-- TEST PASSED --") );
            report "test passed";
        else
            write(l, string'("got data byte; 0x") );
            hwrite(l, rx_data);
            writeline(log_file, l);
            write(l, string'("-- TEST FAILED --") );
            report "test failed";
        end if;
        writeline(log_file, l);
        writeline(log_file, l);


    end procedure;

begin


    dut : entity uart_lib.uart_rx
    port map (
        clk             => clk,
        rst_async       => rst_async,
   
        -- lines
        rx_in            => rx,
   
        -- data
        rx_data_out       => rx_data,
        rx_data_valid_out => rx_data_valid,
   
        -- config
        --max baud rate:
        baud_div_in       => std_logic_vector(to_unsigned(868, 16)),
   
        -- status
        rx_ready_out      => open

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


    -- faking tx
    tx :  process(clk, rst_async)
    begin

      if(rst_async = '0') then
        
        rx <= '1';
        tx_bit_counter <= -1;
        tx_active <= '0';

      elsif(clk'event and clk = '1') then

        if(tx_start = '1') then
          tx_active <= '1';
        end if;

        if(tx_active = '1') then

          if(tx_baud_counter = 0) then
            tx_baud_counter <= 868;

            if(tx_bit_counter = 9) then
              tx_active <= '0';
              tx_bit_counter <= - 1;
            else
              tx_bit_counter <= tx_bit_counter + 1;
            end if;

            if(tx_bit_counter = -1) then
              rx <= '0';
            elsif(tx_bit_counter < 8) then
              rx <= tx_data(tx_bit_counter);
            else
              rx <= '1';
            end if;

          else 
            tx_baud_counter <= tx_baud_counter -1;
          end if;

        end if;

      end if;

    end process;
    

    


    -- Stimulus process
    stim_proc: process
      variable l : line;
    begin

        wait for 20 ns;

        rst_async <= '0';   
        tx_start <= '0';
        tx_data <= (others => '0');


        wait for 20 ns;

        rst_async <= '1';   
        wait for 20 ns; 

        wait for 10 us; 

        for i in 0 to c_amount_of_tests -1 loop

          unit_test(
              l,
              tx_data,
              tx_start,
              test_vectors(i)
          );

          wait for 10 us;
        end loop;

        assert false
          report "Simulation finished"
          severity failure;

        wait; -- stop simulation

    end process;


end test;

