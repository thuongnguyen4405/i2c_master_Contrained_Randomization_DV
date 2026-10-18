SHELL := /bin/bash
.SHELLFLAGS := -o pipefail -c
# Adapted from a screenshot-visible Questa coursework flow. No original protected RTL.
TESTNAME ?= i2c_standard_test
TB_NAME ?= testbench
SEED ?= 1
DUT ?= demo
VLOG ?= vlog
VSIM ?= vsim
RADIX ?= hexadecimal

ifeq ($(DUT),original)
RTL_FILELIST := rtl_original.f
else ifeq ($(DUT),demo)
RTL_FILELIST := rtl_demo.f
else
$(error Invalid DUT=$(DUT): choose demo or original)
endif

.PHONY: all build run wave clean help
all: build run
build:
	vlib work
	vmap work work
	$(VLOG) -sv -f $(RTL_FILELIST) -f tb.f 2>&1 | tee compile.log
run:
	$(VSIM) -sv_seed $(SEED) -l $(TESTNAME).log -voptargs=+acc -c $(TB_NAME) -do "log -r /*;run -all;" +$(TESTNAME)
wave:
	$(VSIM) -i -view vsim.wlf -do "add wave sim:/$(TB_NAME)/*; radix -$(RADIX)" &
clean:
	rm -rf work vsim.dbg *.log *.wlf modelsim.ini transcript compile.log
help:
	@echo "make build DUT=demo (or DUT=original with authorized protected file)"
	@echo "make run TESTNAME=i2c_standard_test|i2c_fast_test|i2c_fast_plus_test"
