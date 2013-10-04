TB = fun_8_tb

FLAGS = --ieee=synopsys -fexplicit
FILES = $(wildcard *.vhd)

all: compile

compile: $(FILES)
	ghdl -a $(FLAGS) *.vhd
	ghdl -e $(FLAGS) $(TB)

run:
	ghdl -r $(FLAGS) $(TB) --vcd=$(TB).vcd

view:
	gtkwave $(TB).vcd

clean:
	ghdl --clean
	rm -f *.vcd work-obj93.cf
