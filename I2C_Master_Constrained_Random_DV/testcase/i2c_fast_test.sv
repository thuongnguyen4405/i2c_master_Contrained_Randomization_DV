// One random transaction constrained to FAST mode.
class i2c_fast_test extends base_test;
    virtual task run_scenario();
        packet pkt;
        pkt = new();
        if (pkt.randomize() with {i2c_mode == FAST;}) begin
            wait (dut_vif.rst_n == 1'b1);
            $display("%0t: [testbench] Run i2c_fast_test", $time);
            $display("ADDR=%0h DATA=%0h LOW=%0d HIGH=%0d HOLD=%0d",
                     pkt.slave_addr, pkt.data_in, pkt.scl_low_time,
                     pkt.scl_high_time, pkt.sda_hold_time);
            send_pkt(pkt);
        end
        else
            $error("[i2c_fast_test] Randomization failed");
    endtask
endclass
