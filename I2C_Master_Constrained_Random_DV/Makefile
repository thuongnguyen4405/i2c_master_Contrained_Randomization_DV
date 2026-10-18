.PHONY: check build run clean
check:
	python3 -m unittest discover -s tests -v
build:
	$(MAKE) -C sim build DUT=demo
run:
	$(MAKE) -C sim run TESTNAME=i2c_standard_test
clean:
	$(MAKE) -C sim clean
