# Before publishing to GitHub

- [ ] Confirm instructor/provider permissions to redistribute screenshot-reconstructed course scaffolding.
- [ ] Keep the original encrypted/protected `.svp` out of Git (already gitignored).
- [ ] Run `python3 -m unittest discover -s tests -v` (sanity checks only).
- [ ] If Questa is available, run all 3 tests with demo; fix any simulator compatibility issues before advertising them as run-tested.
- [ ] If licensed original RTL is available, test it **locally** and independently record results. Never confuse them with demo results.
- [ ] For every mode, capture a log and waveform proving packet selection, START, and timing outputs.
- [ ] Add automated protocol/timing checkers before calling any test PASS (monitor logging alone is observation).
- [ ] Prefer original source export over screenshot reconstruction if it becomes accessible; compare diffs carefully.
- [ ] Record any school permission restrictions and license decisions in NOTICE.
- [ ] Keep screenshots with system account names / protected content off the public repository.

Recommended GitHub repo description:

> Constrained-random SystemVerilog OOP testbench for I2C master timing modes — transaction classes, mailbox-based driver flow and waveform monitoring (educational reconstruction; original protected RTL not included).
