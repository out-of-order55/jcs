module GPIO_IOBUF (
	inout  IO,
	output O, 
	input  I, 
	input  T
);

	assign IO = ~T ? I : 1'bz;// gpio_output_mode
	assign O = T ? IO : I;// gpio_intput_mode
	// assign O = T ? IO : 1'b0;// gpio_intput_mode

endmodule // GPIO_IOBUF

module I2C_IOBUF (
	inout  IO,
	input  T,
	input  I, 
	output O
);

	assign O = T ? IO : I;// original
	assign IO = ~T ? I : 1'bz;// original
	// assign IO = ~T ? IN : 1'b1;// for simulation
	
endmodule // I2C_IOBUF

module SPI_IOBUF (
	inout  IO,
	input  T,
	input  I, 
	output O
);

	assign O = T ? IO : I;// original
	assign IO = ~T ? I : 1'bz;// original
	
endmodule // SPI_IOBUF


