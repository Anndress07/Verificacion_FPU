all:
	iverilog -o hola tb_fpu.sv fpu.v
	vvp hola
	gtkwave fpu.vcd
	rm hola
