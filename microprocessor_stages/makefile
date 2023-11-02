export CORE_ROOT=/home/kulsoom/RV32I_Microprocessor/5_stages_of_singlecycle

all: icarus

icarus: icarus_compile
	vvp $(CORE_ROOT)/temp/5_stages_of_singlecycle.output

icarus_compile:
	mkdir -p temp
	iverilog -f flist -o $(CORE_ROOT)/temp/5_stages_of_singlecycle.output

clean:
	rm -rf temp

