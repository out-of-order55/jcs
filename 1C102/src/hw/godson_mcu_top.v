module godson_mcu_top (
	input         CLK50M,
	input         rst, 
    output        testled,
	// output        pps_led,
	
	input  		  LJTAG_TRST,
	inout  		  LJTAG_TMS, LJTAG_TDO, LJTAG_TDI, LJTAG_TCK,


    // //gpio
    inout          GPIO01,
    inout          GPIO13,
    inout          GPIO18,
    inout          GPIO19,
    inout          GPIO20,

    // //pwm
    // output        PWM01,

    // //uart
    input         uart1_rx_i,
    output        uart1_tx_o

    // //i2c
    // inout         I2C_SCL,
    // inout         I2C_SDA,

    // //spi
	// output  	  SPI_CLK,  
	// input   	  SPI_MISO, 
	// output  	  SPI_MOSI, 
	// output  	  SPI_CSN1, 
	// output  	  SPI_CSN2, 
	// output  	  SPI_CSN3
    );
    assign testled = timer_test;
    wire    RSTN=!rst;
	parameter ADDR_APB = 32,
			  DATA_APB_8 = 8,
			  DATA_APB_32 = 32;
    parameter RESET_TIME = 40000000;// 5s

	wire    clk_ext8m;
    wire [5:0]  interrupt = {1'b0,int_o,4'b0};

	reg [29 : 0] rst_cnt = 0;
	always @(posedge CLK50M or negedge RSTN)
	begin
        if(!RSTN) rst_cnt <= 0;
		else if(rst_cnt==RESET_TIME) rst_cnt <= rst_cnt;
		else rst_cnt <= rst_cnt + 1;
	end
	wire por_rst_n = (rst_cnt == RESET_TIME) ? 1'b1 : 1'b0;

	reg [22 : 0] cnt = 0;
	always @(posedge clk_ext8m)
		begin
			cnt <= cnt + 1;
		end
		
	assign pps_led = cnt[21];

    wire pll_lock;
    Gowin_PLL  pll_CLK50M_to_8M(
        .lock(pll_lock),    //output lock
        .clkout0(clk_ext8m),//output clkout0
        .clkin(CLK50M), 	//input clkin
        .reset(~por_rst_n)  //input reset
    );

	wire          			  apb0_psel;
	wire [ADDR_APB-1:0]       apb0_paddr;
	wire           			  apb0_pwrite;
	wire           			  apb0_penable;
	wire [DATA_APB_32-1:0]    apb0_pwdata;
	wire [DATA_APB_32-1:0]    apb0_prdata;
	wire           gpio_ack = gpio_penable;


    //gpio
    wire         gpio_psel;
    wire  [31:0] gpio_paddr;
    wire         gpio_pwrite;
    wire         gpio_penable;
    wire  [31:0] gpio_pwdata;
    wire  [31:0] gpio_prdata;

    //pwm
    wire         pwm_psel;
    wire  [31:0] pwm_paddr;
    wire         pwm_pwrite;
    wire         pwm_penable;
    wire  [31:0] pwm_pwdata;
    wire  [31:0] pwm_prdata;
    wire         pwm_ack = pwm_penable;

    //hpet
    wire         timer_psel;
    wire  [31:0] timer_paddr;
    wire         timer_pwrite;
    wire         timer_penable;
    wire  [31:0] timer_pwdata;
    wire  [31:0] timer_prdata;
    wire         timer_ack = timer_penable;
    //wire         timer_int;

    //confreg
    wire         confreg_psel;
    wire  [19:0] confreg_paddr;
    wire         confreg_pwrite;
    wire         confreg_penable;
    wire  [7:0]  confreg_pwdata;
    wire  [7:0]  confreg_prdata;
    wire         confreg_int;
    wire         confreg_ack = confreg_penable;
    wire         timer_int;
    wire         i2c_int;
    wire         uart1_int;
    wire         uart0_int;
    wire         flash_int;
    wire         spi_int;
    wire         vpwm_int;
    wire         dma_int;
    wire         int_o;

    //uart
    wire         uart1_psel;
    wire [31:0]  uart1_paddr;
    wire         uart1_pwrite;
    wire         uart1_penable;
    wire [31:0]  uart1_pwdata;
    wire [31:0]  uart1_prdata;
    wire         uart1_ack=uart1_penable;
    //wire         uart1_rx_i;
    //wire         uart1_tx_0;
    //wire         uart1_int;
 
    //i2c
    wire         i2c_psel;
    wire [31:0]  i2c_paddr;
    wire         i2c_pwrite;
    wire         i2c_penable;
    wire [7:0]   i2c_pwdata;
    wire [7:0]   i2c_prdata;   
    wire   i2c_ack = i2c_penable; 

    //spi
    wire         spi_psel;
    wire [3:0]   spi_paddr;
    wire         spi_pwrite;
    wire         spi_penable;
    wire [7:0]   spi_pwdata;
    wire [7:0]   spi_prdata; 
    wire   spi_ack = spi_penable;  

	godson_mcu_cpu A_cpu
	(
		.reset            (pll_lock         ),// (por_rst_n        ),
		.clock            (clk_ext8m        ),

		.ljtag_trst_i     (LJTAG_TRST       ),
		.ljtag_tms_i      (LJTAG_TMS        ),
		.ljtag_tdo_o      (LJTAG_TDO        ),
		.ljtag_tdi_i      (LJTAG_TDI        ),
		.ljtag_tck_i      (LJTAG_TCK        ),

		.apb0_psel        (gpio_psel        ),
		.apb0_paddr       (gpio_paddr       ),
		.apb0_pwrite      (gpio_pwrite      ),
		.apb0_penable     (gpio_penable     ),
		.apb0_pwdata      (gpio_pwdata      ),
		.apb0_prdata      (gpio_prdata      ),
		.apb0_ack         (gpio_ack         ),

		.apb1_psel        (pwm_psel         ),
		.apb1_paddr       (pwm_paddr        ),
		.apb1_pwrite      (pwm_pwrite       ),
		.apb1_penable     (pwm_penable      ),
		.apb1_pwdata      (pwm_pwdata       ),
		.apb1_prdata      (pwm_prdata       ),
		.apb1_ack         (pwm_ack),

		.apb2_psel        (timer_psel        ),
		.apb2_paddr       (timer_pwrite      ),
		.apb2_pwrite      (timer_paddr       ),
		.apb2_penable     (timer_penable     ),
		.apb2_pwdata      (timer_pwdata      ),
		.apb2_prdata      (timer_prdata      ),
		.apb2_ack         (timer_ack),

		.apb3_psel        (confreg_psel        ),
		.apb3_paddr       (confreg_pwrite      ),
		.apb3_pwrite      (confreg_paddr       ),
		.apb3_penable     (confreg_penable     ),
		.apb3_pwdata      (confreg_pwdata      ),
		.apb3_prdata      (confreg_prdata      ),
		.apb3_ack         (confreg_ack),

		.apb4_psel        (uart1_psel         ),
		.apb4_paddr       (uart1_pwrite       ),
		.apb4_pwrite      (uart1_paddr        ),
		.apb4_penable     (uart1_penable      ),
		.apb4_pwdata      (uart1_pwdata       ),
		.apb4_prdata      (uart1_prdata       ),
		.apb4_ack         (uart1_ack           ),

		.apb5_psel        (i2c_psel           ),
		.apb5_paddr       (i2c_pwrite         ),
		.apb5_pwrite      (i2c_paddr            ),
		.apb5_penable     (i2c_penable        ),
		.apb5_pwdata      (i2c_pwdata         ),
		.apb5_prdata      (i2c_prdata         ),
		.apb5_ack         (i2c_ack),

		.apb6_psel        (spi_psel           ),
		.apb6_paddr       (spi_pwrite         ),
		.apb6_pwrite      (spi_paddr            ),
		.apb6_penable     (spi_penable        ),
		.apb6_pwdata      (spi_pwdata         ),
		.apb6_prdata      (spi_prdata         ),
		.apb6_ack         (spi_ack),

		.apb7_psel        (),
		.apb7_paddr       (),
		.apb7_pwrite      (),
		.apb7_penable     (),
		.apb7_pwdata      (),
		.apb7_prdata      (),
		.apb7_ack         (),

		.apb8_psel        (),
		.apb8_paddr       (),
		.apb8_pwrite      (),
		.apb8_penable     (),
		.apb8_pwdata      (),
		.apb8_prdata      (),
		.apb8_ack         (),
		.interrupt        (interrupt)
	);



    // gpio (0xbfeb_xxxx） below
    apb_gpio A_gpio
    (
        .apb_pclk       (clk_ext8m   ),
        .apb_prstn      (RSTN        ),
        .apb_psel       (gpio_psel   ),
        .apb_paddr      (gpio_paddr  ),
        .apb_pwrite     (gpio_pwrite ),
        .apb_penable    (gpio_penable),
        .apb_pwdata     (gpio_pwdata ),
        .apb_prdata     (gpio_prdata ),

        .GPIO01         (GPIO01),
        .GPIO13         (GPIO13),
        .GPIO18         (GPIO18),
        .GPIO19         (GPIO19),
        .GPIO20         (GPIO20)
    );
    //gpio above

    // pwm (0xbfec_xxxx） below
    apb_pwm A_pwm
    (
        .apb_pclk       (clk_ext8m   ),
        .apb_prstn      (RSTN        ),
        .apb_psel       (pwm_psel   ),
        .apb_paddr      (pwm_paddr  ),
        .apb_pwrite     (pwm_pwrite ),
        .apb_penable    (pwm_penable),
        .apb_pwdata     (pwm_pwdata ),
        .apb_prdata     (pwm_prdata ),

        .PWM01        (PWM01)
    );
    //pwm above

    // timer(0xbfed_xxxx) below
    HPET_TOP A_timer
    (
        .apb_pclk       (clk_ext8m        ),
        .apb_prstn      (RSTN             ),
        .apb_psel       (timer_psel      ),
        .apb_pwrite     (timer_pwrite     ),
        .apb_paddr      (timer_paddr[3:0] ),
        .apb_penable    (timer_penable),
        .apb_pwdata     (timer_pwdata     ),
        .apb_prdata     (timer_prdata     ),

        .int_o          (timer_int)
    );

    reg     timer_test;
    always @(posedge clk_ext8m) begin
        if(!RSTN)begin
            timer_test <= 'b1;
        end
        else if(timer_int)begin
            timer_test <= 'b0;
        end
    end
    //confreg
    CONFREG confreg
    (
        .apb_pclk       (clk_ext8m          ),
        .apb_prstn      (RSTN               ),
        .apb_psel       (confreg_psel       ),
        .apb_pwrite     (confreg_pwrite     ),
        .apb_paddr      (confreg_paddr      ),
        .apb_penable    (confreg_penable    ),
        .apb_pwdata     (confreg_pwdata     ),
        .apb_prdata     (confreg_prdata     ),
        .timer_int      (timer_int),
        .i2c_int        (i2c_int  ),
        .uart1_int      (uart1_int),
        .uart0_int      (uart0_int  ),
        .flash_int      (flash_int),
        .spi_int        (spi_int ),
        .vpwm_int       (vpwm_int),
        .dma_int        (dma_int ),
        .int_o          (int_o  )
    );

    //uart (0xbfe8_8xxx) blew
    UART_TOP A_uart1
    (
        .apb_pclk       (clk_ext8m        ),
        .apb_prstn      (RSTN             ),
        .apb_psel       (uart1_psel       ),
        .apb_pwrite     (uart1_pwrite     ),
        .apb_paddr      (uart1_paddr      ),
        .apb_penable    (uart1_penable    ),
        .apb_pwdata     (uart1_pwdata     ),
        .apb_prdata     (uart1_prdata     ),
        .RsRx           (uart1_rx_i       ),
        .RsTx           (uart1_tx_o       ),
        .uart_irq       (uart1_int        )
    );
    //uart above

    //2c (0xbfe9_xxxx） below
    I2C_TOP i2c_top
    (
        .apb_pclk       (clk_ext8m          ),
        .apb_prstn      (RSTN               ),
        .apb_psel       (i2c_psel           ),
        .apb_pwrite     (i2c_pwrite         ),
        .apb_paddr      (i2c_paddr[2:0]     ),
        .apb_penable    (i2c_penable        ),
        .apb_pwdata     (i2c_pwdata         ),
        .apb_prdata     (i2c_prdata         ),
        .I2C_SCL        (I2C_SCL            ),
        .I2C_SDA        (I2C_SDA            ),
        .i2c_int        (i2c_int            )
    );
    //i2c above

    //spi (0xbfe7_xxxx) below
    SPI_TOP spi_top
    (
        .apb_pclk       (clk_ext8m          ),
        .apb_prstn      (RSTN               ),
        .apb_psel       (spi_psel           ),
        .apb_pwrite     (spi_pwrite         ),
        .apb_paddr      (spi_paddr[3:0]     ),
        .apb_penable    (spi_penable        ),
        .apb_pwdata     (spi_pwdata         ),
        .apb_prdata     (spi_prdata         ),
        .SPI_CLK        (SPI_CLK            ),
        .SPI_MISO       (SPI_MISO           ),
        .SPI_MOSI       (SPI_MOSI           ),
        .SPI_CSN1       (SPI_CSN1           ),
        .SPI_CSN2       (SPI_CSN2           ),
        .SPI_CSN3       (SPI_CSN3           ),
        .spi_int        (spi_int            )
    );
    //spi above
endmodule


