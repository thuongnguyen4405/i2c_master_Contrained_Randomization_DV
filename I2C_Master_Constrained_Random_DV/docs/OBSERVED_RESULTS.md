# Observed simulation results — provenance-aware

A user-provided Questa screenshot showed the following observations on the **original course environment** (not on the separately authored demo):

```text
[environment] build
[environment] run
[testbench] Run i2c_standard_test
ADDR=4f DATA=c6 LOW=542 HIGH=458 HOLD=215
[stimulus] Sent packet to driver
[driver] Get packet from stimulus
[monitor] Start condition detect
[monitor] TSCL_Low = 5420, TSCL_High = 4580
[monitor] TSDA_Hold = 2150, TSCL_Setup = 3270
[base_test] End simulation
```

**Important caveat:** The terminal command at that moment requested `TESTNAME=i2c_fast_test` but the bench remained hard-coded to **Standard**. These observations are **Standard**, not Fast, evidence. No final full Fast or Fast Plus successful monitor outputs have been provided. The runnable demo model was not used in that original log and has not been tested here.

Sanity check: LOW + HIGH = 10,000 ns ⇒ 100 kHz. Reported setup = 5,420 − 2,150 = 3,270 ns. Values can be checked against Standard minimum timing from the PDF, but are not automatically asserted by this bench.
