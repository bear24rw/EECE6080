FLAGS = --ieee=synopsys -fexplicit
FILES = $(wildcard *.vhd)

all: compile

compile: $(FILES)
	ghdl -a $(FLAGS) *.vhd
	ghdl -e $(FLAGS) $(tb)

run:
	ghdl -r $(FLAGS) $(tb) --vcd=$(tb).vcd

view:
	gtkwave $(tb).vcd

clean:
	ghdl --clean
	rm -f work-obj93.cf
