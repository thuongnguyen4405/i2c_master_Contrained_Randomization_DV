// Transaction timing constraint (100 MHz system clock => 10 ns per count).
class packet;
    typedef enum {STANDARD, FAST, FAST_PLUS} i2c_mode_enum;
    rand bit [6:0] slave_addr;
    rand bit [7:0] data_in;
    rand bit [15:0] scl_low_time;
    rand bit [15:0] scl_high_time;
    rand bit [15:0] sda_hold_time;
    rand i2c_mode_enum i2c_mode;

    constraint i2c_timing_c {
        if (i2c_mode == STANDARD) {
            scl_low_time >= 470;
            scl_high_time >= 400;
            scl_low_time + scl_high_time == 1000;
            sda_hold_time >= 30;
            // Corrected from screenshot's +10 to spec-required 250ns = 25 cycles.
            scl_low_time >= sda_hold_time + 25;
        }
        else if (i2c_mode == FAST) {
            scl_low_time >= 130;
            scl_high_time >= 60;
            scl_low_time + scl_high_time == 250;
            sda_hold_time >= 30;
            scl_low_time >= sda_hold_time + 10;
        }
        else if (i2c_mode == FAST_PLUS) {
            scl_low_time >= 50;
            scl_high_time >= 26;
            scl_low_time + scl_high_time == 100;
            sda_hold_time >= 30;
            scl_low_time >= sda_hold_time + 5;
        }
    }

    function new();
    endfunction
endclass
