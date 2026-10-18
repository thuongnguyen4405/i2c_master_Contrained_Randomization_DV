# Source provenance & known limitations

**Input:** student-provided terminal/editor screenshots only. Not an original ZIP, file-system snapshot or verified source export.

## Parts grounded in screenshots

- Original project tree, module port list, `protected` RTL name, package includes, timing constraints, `stimulus`, `driver`, `environment`, `base_test`, three derived tests, and `testbench` plusarg selection.
- System clock 100 MHz and reset deassertion after 100 ns.
- Monitor: START detector, SCL measurement, reporting and beginning of SDA hold detection.

## Transparent adaptations

1. **RTL:** `rtl/demo/i2c_master_control_demo.sv` was independently authored. Original `rtl/i2c_master_control.svp` is protected and excluded; this demo is not a stand-in for DUT equivalence or compliance.
2. **Monitor:** `detect_sda_hold` was *not fully visible*. Its remainder is an educational reconstruction, not recovered original code.
3. **Standard constraint:** a final screenshot read `scl_low_time >= sda_hold_time + 10`. Homework table specified 250 ns minimum Standard setup ⇒ **+25** cycles at 10 ns. We corrected this and marked the changed line in `packet.sv`.
4. **Harness:** default `base_test` object was replaced by plusarg-selected derived objects. No-match `$fatal` was added for clarity.
5. **Build:** modified Makefile/Filelists permit `DUT=demo` vs `DUT=original`; campus `setup_dva` is an optional call.
6. Documentation, CI and demo source were not shown in screenshots and are independently authored.

## Scope and validation

- **No Questa / ModelSim run** was possible during this packaging. SystemVerilog compilation and behavioral simulation of the reconstructed repo are unverified.
- Python unit tests verify only timing arithmetic and repo structure, **not HDL correctness**.
- User logs supported at least one observed Standard-mode timing trace. Successful end-to-end Fast and Fast Plus results were not supplied.
- The monitor does not contain a self-checking scoreboard, covergroups or full I2C assertions.
- The queue size check uses the standards-compliant `pkt_q.size()` method syntax; a screenshot appeared to omit parentheses.
7. No license for instructor materials is conveyed; check publishing rights.
