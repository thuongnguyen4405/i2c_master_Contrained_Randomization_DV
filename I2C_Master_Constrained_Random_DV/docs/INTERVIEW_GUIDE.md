# Interview explanation and Q&A

## 45-second English project pitch

> I implemented a lightweight, transaction-based SystemVerilog verification environment for an I2C master timing controller. I created constrained-random packet generation for Standard, Fast and Fast Plus modes; each derived testcase restricts the mode through inline randomization. Transactions flow through stimulus queueing, a typed mailbox, and a driver connected by a virtual interface. A monitor observes SCL and SDA to report actual timing. I also debugged polymorphic testcase selection, reset synchronization, and a case where an overly broad timing constraint made SCL too slow for the simulation timeout.

## Vietnamese explanation

> Em xây dựng testbench SystemVerilog OOP cho I2C Master. Em viết constraint timing của ba mode, tạo testcase kế thừa `base_test` và dùng inline randomization để chọn mode. Packet được gửi qua stimulus, mailbox và driver đến DUT. Monitor đo SCL LOW/HIGH và SDA HOLD/SETUP. Khi debug em xử lý chọn nhầm class cha, gửi packet khi reset chưa nhả và timing random quá dài so với simulation timeout.

## Common questions

**Why `==` instead of `>=`?** The goal is *at the maximum allowed rate*. With `>=`, an arbitrarily slow legal transaction can be longer than the fixed 300 µs simulation timeout.

**What is the point of `virtual`?** Dynamic dispatch based on the actual object type. Inheriting a method does not mean a derived testcase will run if the harness constructs only the base class.

**Why use a mailbox?** To decouple transaction generation from cycle-timed driving, using producer-consumer synchronization.

**What does the monitor prove?** It reports measured edges. Without independently comparing all observations against spec, it does not prove full correctness.

**Why wait for reset?** The DUT must be active before it accepts START and configuration.

**Is this UVM?** No. This is a custom class-based environment illustrating concepts also used in UVM.

**What would you add next?** Assertion coverage, scoreboard, multiseed regression, randomized reset, waveform-aware protocol checker, clocking blocks, negative cases and I2C corner cases.

## CV bullet

- Built a SystemVerilog OOP testbench for 3 I2C master operating modes, with constrained-random transactions, inherited test scenarios, mailbox-driven stimulus, virtual-interface driving and edge-based timing observations.

## Do not overclaim

The course DUT source was protected and not bundled. The demo is an independent educational model; the monitor is partly reconstructed. Do not claim successful design signoff, full I2C protocol compliance, UVM expertise based solely on this project, or Fast/Fast Plus verification results that were not captured.
