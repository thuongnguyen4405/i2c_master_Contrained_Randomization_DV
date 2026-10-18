// EDUCATIONAL DEMONSTRATION DUT -- NOT THE ORIGINAL PROTECTED COURSE RTL.
// Standalone behavioral traffic generator (non-synthesizable, incomplete I2C).
// Does not model real open-drain, ACK slave, stretching or arbitration.
`timescale 1ns/1ps
module i2c_master_control(
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [7:0] data_in,
    input wire [6:0] slave_addr,
    input wire [15:0] scl_low_time,
    input wire [15:0] scl_high_time,
    input wire [15:0] sda_hold_time,
    output reg scl,
    output reg sda,
    output reg done
);
    integer idx;
    integer low_cycles, high_cycles, hold_cycles;
    reg [6:0] addr_latched;
    reg [7:0] data_latched;

    task automatic send_bit(input bit value);
        scl = 1'b0;
        repeat (hold_cycles) @(posedge clk);
        sda = value;
        repeat (low_cycles - hold_cycles) @(posedge clk);
        scl = 1'b1;
        repeat (high_cycles) @(posedge clk);
    endtask

    initial begin
        scl = 1'b1;
        sda = 1'b1;
        done = 1'b0;
        forever begin
            @(posedge start);
            if (rst_n === 1'b1) begin
                // Driver raises START before assigning timing fields on the
                // same clock edge. Latch inputs on the following falling edge
                // to avoid an active-region scheduling race in this demo.
                @(negedge clk);
                low_cycles = int'(scl_low_time);
                high_cycles = int'(scl_high_time);
                hold_cycles = int'(sda_hold_time);
                addr_latched = slave_addr;
                data_latched = data_in;
                done = 1'b0;
                repeat (3) @(posedge clk);
                sda = 1'b0; // START: SDA falls with SCL high
                repeat (2) @(posedge clk);
                for (idx = 6; idx >= 0; idx = idx - 1)
                    send_bit(addr_latched[idx]);
                send_bit(1'b0); // write direction
                for (idx = 7; idx >= 0; idx = idx - 1)
                    send_bit(data_latched[idx]);
                send_bit(1'b1); // placeholder ACK slot, no slave modeled
                scl = 1'b0;
                sda = 1'b0;
                repeat (low_cycles) @(posedge clk);
                scl = 1'b1;
                repeat (high_cycles) @(posedge clk);
                sda = 1'b1;
                done = 1'b1;
                @(posedge clk);
                done = 1'b0;
            end
        end
    end
endmodule
