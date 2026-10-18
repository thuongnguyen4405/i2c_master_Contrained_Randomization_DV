# Verification plan — scope and traceability

The DUT receives a 100 MHz clock and 16-bit timing counts. Verify mode-specific legal timing and observe actual SCL/SDA output. This exercise is **not** protocol compliance sign-off.

| Specification item | Standard | Fast | Fast Plus |
|---|---:|---:|---:|
| Maximum rate | 100 kHz | 400 kHz | 1 MHz |
| Minimum LOW (cycles) | 470 | 130 | 50 |
| Minimum HIGH (cycles) | 400 | 60 | 26 |
| Period at max rate (cycles) | **1000** | **250** | **100** |
| Minimum HOLD (cycles) | 30 | 30 | 30 |
| Minimum SETUP (cycles) | 25 | 10 | 5 |

## Test plan

| Test | Inline `i2c_mode` | Count | Expected behavior |
|---|---|---:|---|
| `i2c_standard_test` | `STANDARD` | 1 | Send configured 100 kHz timing packet. |
| `i2c_fast_test` | `FAST` | 1 | Send configured 400 kHz timing packet. |
| `i2c_fast_plus_test` | `FAST_PLUS` | 1 | Send configured 1 MHz timing packet. |

## Verification steps

1. Compile packages and DUT, check compile errors.
2. Select testcase via `TESTNAME`; confirm displayed class selection.
3. Wait until reset deassertion; randomize packet under appropriate constraints.
4. Confirm Stimulus→Driver logs and observable START event.
5. Capture monitored SCL Low/High, SDA Hold/Setup, compare to mode table and requested SCL period.
6. Repeat with different seeds, then eventually automate assertions/scoreboard/coverage.

## What is not yet claimed

No automated scoreboard, no functional coverage, no regression sign-off, no clock stretching/arbitration/slave ACK checking, no full protocol compliance. Recorded monitor values are measurements to examine, not a formal PASS signal.
