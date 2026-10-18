# Protected RTL and independent demo

The screenshot showed `rtl/i2c_master_control.svp` with a SystemVerilog `protected` payload. The **actual original RTL is not included** and cannot be recovered from a picture. Obtain it from the authorized course/provider and put it at `rtl/i2c_master_control.svp` locally (gitignored) to use `make build DUT=original`.

`rtl/demo/i2c_master_control_demo.sv` is a separately authored, **non-synthesizable, intentionally incomplete behavioral demo** for understanding the testbench path. It is not functionally equivalent to the course RTL and is not evidence of compliance. The source screenshot also omitted the tail of the monitor, so the monitor's missing tail was independently recreated and is clearly marked.
