module apb_gpio (
    input           apb_pclk,
    input           apb_prstn,
    input           apb_psel,
    input  [31:0]   apb_paddr,
	input           apb_pwrite,
    input           apb_penable,
    input  [31:0]   apb_pwdata,
    output [31:0]   apb_prdata,

    inout           GPIO01,
	inout           GPIO13,
	inout           GPIO18,
	inout           GPIO19,
	inout           GPIO20,
	inout           GPIO34,
	inout           GPIO35,
	inout           GPIO36,
	inout           GPIO37,
	inout           GPIO38,
	inout           GPIO39,
	inout           GPIO40

);

	reg [31:0]       gpioa_oe_r;
	reg [31:0]       gpioa_o_r; 
	reg [31:0]       gpiob_oe_r;
	reg [31:0]       gpiob_o_r; 

	wire we = apb_penable & apb_psel & apb_pwrite;
	wire re = apb_penable & apb_psel &~apb_pwrite;

	always @(posedge apb_pclk or negedge apb_prstn) 
	begin
		if (!apb_prstn) 
		begin
			gpioa_oe_r <= 32'b0;
			gpioa_o_r  <= 32'b0;
			gpiob_oe_r <= 32'b0;
			gpiob_o_r  <= 32'b0;
		end 
		else if (we) 
		begin
			case (apb_paddr[7:0])
				8'h40: gpioa_oe_r <= apb_pwdata;
				8'h44: gpioa_o_r  <= apb_pwdata;
				8'h50: gpiob_oe_r <= apb_pwdata;
				8'h54: gpiob_o_r  <= apb_pwdata;
				default: ; // nothing to do
			endcase
		end
	end

	wire [31:0] gpioa_oe;
	wire [31:0] gpioa_o ;
	wire [31:0] gpioa_i ;
	wire [31:0] gpiob_oe;
	wire [31:0] gpiob_o ;
	wire [31:0] gpiob_i ;

	assign gpioa_oe = gpioa_oe_r[31:0];
	assign gpioa_o  = gpioa_o_r[31:0] ;
	assign gpiob_oe = gpiob_oe_r[31:0];
	assign gpiob_o  = gpiob_o_r[31:0] ;
	
	reg  [31:0]     rdata;
	always @(*) begin
		if(~apb_psel | apb_pwrite) 
			rdata = 32'b0;
		else if (re)
		begin
			case (apb_paddr[7:0])
				8'h40: rdata = gpioa_oe;
				8'h44: rdata = gpioa_o ;
				8'h48: rdata = gpioa_i ;
				8'h50: rdata = gpiob_oe;
				8'h54: rdata = gpiob_o ;
				8'h58: rdata = gpiob_i ;
				default: rdata = 32'b0;
			endcase
		end
	end

	assign apb_prdata = rdata;

	GPIO_IOBUF pad_GPIO01 (.IO(GPIO01), .O(gpioa_i[1] ), .I(gpioa_o[1] ), .T(~gpioa_oe[1] ));

    GPIO_IOBUF pad_GPIO13 (.IO(GPIO13), .O(gpioa_i[13]), .I(gpioa_o[13]), .T(~gpioa_oe[13]));
	GPIO_IOBUF pad_GPIO18 (.IO(GPIO18), .O(gpioa_i[18]), .I(gpioa_o[18]), .T(~gpioa_oe[18]));
	GPIO_IOBUF pad_GPIO19 (.IO(GPIO19), .O(gpioa_i[19]), .I(gpioa_o[19]), .T(~gpioa_oe[19]));
	GPIO_IOBUF pad_GPIO20 (.IO(GPIO20), .O(gpioa_i[20]), .I(gpioa_o[20]), .T(~gpioa_oe[20]));
/*
	GPIO_IOBUF pad_GPIO34 (.IO(GPIO34), .O(gpiob_i[2] ), .I(gpiob_o[2] ), .T(~gpiob_oe[2] ));
	GPIO_IOBUF pad_GPIO35 (.IO(GPIO35), .O(gpiob_i[3] ), .I(gpiob_o[3] ), .T(~gpiob_oe[3] ));
	GPIO_IOBUF pad_GPIO36 (.IO(GPIO36), .O(gpiob_i[4] ), .I(gpiob_o[4] ), .T(~gpiob_oe[4] ));
	GPIO_IOBUF pad_GPIO37 (.IO(GPIO37), .O(gpiob_i[5] ), .I(gpiob_o[5] ), .T(~gpiob_oe[5] ));
	GPIO_IOBUF pad_GPIO38 (.IO(GPIO38), .O(gpiob_i[6] ), .I(gpiob_o[6] ), .T(~gpiob_oe[6] ));
	GPIO_IOBUF pad_GPIO39 (.IO(GPIO39), .O(gpiob_i[7] ), .I(gpiob_o[7] ), .T(~gpiob_oe[7] ));
	GPIO_IOBUF pad_GPIO40 (.IO(GPIO40), .O(gpiob_i[8] ), .I(gpiob_o[8] ), .T(~gpiob_oe[8] ));
*/

endmodule


