library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

library uart_lib;
use uart_lib.uart_pkg_e.all;

entity tb_uart is
end tb_uart;


architecture test of tb_uart is

    signal clk          : std_logic := '0';
    signal rst_async    : std_logic := '0';


    signal tx_data        : std_logic_vector(7 downto 0);
    signal tx_data_valid  : std_logic;

    signal rx_data        : std_logic_vector(7 downto 0);
    signal rx_data_valid  : std_logic;

    signal txrx : std_logic;

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
        variable l            : inout line;
        signal tx_data        : out std_logic_vector(7 downto 0);
        signal tx_data_valid  : out std_logic;
        constant data         : in std_logic_vector(7 downto 0);
        variable v_testbench_passed : inout boolean
    ) is
    begin

        write(l, string'("----- TEST -----"));
        writeline(log_file, l);

        write(l, string'("data byte; 0x") );
        hwrite(l, data);
        writeline(log_file, l);


        tx_data       <= data;
        tx_data_valid <= '1';
        wait until rising_edge(clk);
        tx_data_valid <= '0';


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
            v_testbench_passed := false;
            report "test failed";
        end if;
        writeline(log_file, l);
        writeline(log_file, l);


    end procedure;


begin


    dut : entity uart_lib.uart
    port map (
        clk             => clk,
        rst_async       => rst_async,
   
        -- lines
        tx_out            => txrx,
        rx_in             => txrx,
   
        -- data
        tx_data_in        => tx_data,
        tx_data_valid_in  => tx_data_valid,
   
        rx_data_out       => rx_data,
        rx_data_valid_out => rx_data_valid,
        rx_framing_error_out => open,

        -- config
        --max baud rate:
        baud_div_in       => std_logic_vector(to_unsigned(868, 16)),
   
        -- status
        tx_ready_out      => open,
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


    
    -- Stimulus process
    stim_proc: process
      variable l : line;
      variable v_testbench_passed : boolean;
    begin

        wait for 20 ns;

        rst_async <= '0';   
        tx_data <= "01000001";
        tx_data_valid <= '0';


        wait for 20 ns;

        rst_async <= '1';   
        wait for 20 ns; 

        wait for 10 us; 

        v_testbench_passed := true;
        for i in 0 to c_amount_of_tests -1 loop

          unit_test(
              l,
              tx_data,
              tx_data_valid,
              test_vectors(i),
              v_testbench_passed
          );

          wait for 10 us;
        end loop;


        wait for 100 us; 
        wait until clk'event and clk = '1';


        writeline(log_file, l);
        write(l, string'("===============") );
        writeline(log_file, l);
        if v_testbench_passed then
            write(l, string'("-- TESTBENCH PASSED --") );
            report "testbench passed";
        else
            write(l, string'("-- TESTBENCH FAILED --") );
            report "testbench failed";
        end if;
        writeline(log_file, l);
        write(l, string'("===============") );
        writeline(log_file, l);


        assert false
          report "Simulation finished"
          severity failure;

        wait; -- stop simulation

    end process;


end test;

