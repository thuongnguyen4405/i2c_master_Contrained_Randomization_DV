// Screenshot captured monitor only up to ~line 48; detect_sda_hold below
// is an INDEPENDENT educational reconstruction, not the original source.
// This monitor prints observations; it has no automated PASS/FAIL checker.
class monitor;
    virtual dut_if dut_vif;
    time tscl_high = 0;
    time tscl_low = 0;
    time tsda_hold = 0;

    function new(virtual dut_if dut_vif);
        this.dut_vif = dut_vif;
    endfunction

    task run();
        while (1) begin
            do begin
                @(negedge dut_vif.sda);
            end while (!(dut_vif.sda === 1'b0 && dut_vif.scl === 1'b1));
            $display("%0t: [monitor] Start condition detect", $time);
            fork
                detect_scl();
                detect_sda_hold();
            join
            $display("%0t: [monitor] TSCL_Low = %0t, TSCL_High = %0t", $time, tscl_low, tscl_high);
            $display("%0t: [monitor] TSDA_Hold = %0t, TSCL_Setup = %0t", $time, tsda_hold, tscl_low - tsda_hold);
        end
    endtask

    task detect_scl();
        time tscl_1, tscl_2;
        @(posedge dut_vif.scl);
        tscl_1 = $time;
        @(negedge dut_vif.scl);
        tscl_high = $time - tscl_1;
        tscl_2 = $time;
        @(posedge dut_vif.scl);
        tscl_low = $time - tscl_2;
    endtask

    // Recreated from expected timing behavior: measure an SDA transition
    // while SCL low relative to the last preceding falling SCL edge.
    task detect_sda_hold();
        time edge_time;
        bit captured;
        captured = 0;
        repeat (2) @(negedge dut_vif.scl);
        while (!captured) begin
            edge_time = $time;
            fork : sample_hold
                begin
                    @(posedge dut_vif.sda or negedge dut_vif.sda);
                    if (dut_vif.scl === 1'b0) begin
                        tsda_hold = $time - edge_time;
                        captured = 1;
                    end
                end
                begin
                    @(posedge dut_vif.scl);
                end
            join_any
            disable sample_hold;
            if (!captured) @(negedge dut_vif.scl);
        end
    endtask
endclass
