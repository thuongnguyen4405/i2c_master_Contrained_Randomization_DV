# Debug story — actual issues encountered

### 1) No testcase logs despite clean compile
Initial harness constructed `base_test base = new()`; base `run_scenario()` is intentionally empty. Adding a derived class to `test_pkg` just compiles it; it does not execute it. The harness must construct the selected derived class, then assign its handle to `base`.

### 2) Stimulus runs at time zero
The DUT reset remains asserted until 100 ns. Scenario initially sent at time 0; waiting for `dut_vif.rst_n == 1` before `send_pkt(pkt)` solved this ordering issue.

### 3) Monitor sees START but not timings
With `LOW + HIGH >= 1000`, the random solver generated one example: `LOW=34472 HIGH=44444 HOLD=9515`. At 100 MHz these are `344.72 µs` low and `444.44 µs` high, **789.16 µs per SCL period**. The base test ends at about **300.1 µs**, so the monitor cannot observe a full period. The constraint did not *block* the monitor; it made DUT activity too slow for the test timeout. For this test target `LOW + HIGH == 1000/250/100` generates the maximum configured rate.

### 4) `TESTNAME=i2c_fast_test` still runs Standard
Temporarily hard-coding `i2c_standard_test base = new()` ignores the plusarg. The Makefile passes `+$(TESTNAME)`, but only `$test$plusargs`-based dispatch in the harness can use it to instantiate the correct object.

### 5) Virtual interface typo
`dut_if` is the **type**, `dut_vif` is the test's **handle**. Correct syntax is `wait(dut_vif.rst_n == 1'b1)`.

### 6) Setup mismatch spotted when packaging
The final screenshot of Standard constraint used `scl_low_time >= sda_hold_time + 10` even though the PDF requires Standard SDA setup ≥250 ns = 25 system clock cycles. The portfolio version corrects this to +25 and documents that difference.

**Remember:** Compile success, successful randomization, actual DUT activity, and timing verification are four different levels of evidence.
