`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2021 07:03:30 PM
// Design Name: 
// Module Name: reg_file_4x8_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module reg_file_tb;

	// ------------------------------------------------------------------------
	// Local parameters
	// ------------------------------------------------------------------------

	localparam real REFCLK_FREQUENCY      = 33.00e6; 


	// Clock periods
	localparam time REFCLK_PERIOD      = (1.0e9/REFCLK_FREQUENCY)*1ns;
	
	localparam DATA_WIDTH = 8; // number of bits
	localparam ADDR_WIDTH = 2; // number of address bits

	// -------------------------------------------------------------------------
	// Internal Signals
	// -------------------------------------------------------------------------
	//
	// Clocks
	logic sys_clk;
	
    //ogic
    logic wr_en;
    logic [ADDR_WIDTH-1:0] w_addr;
    logic    [7:0]   w_data;
    
    logic [ADDR_WIDTH-1:0] r_addr;
    logic    [7:0]   r_data;
    

	// -------------------------------------------------------------------------
	// REFCLK generator
	// -------------------------------------------------------------------------
	//
	initial begin
		sys_clk = 1'b0;
		forever begin
			#(REFCLK_PERIOD/2) sys_clk = ~sys_clk;
		end
	end

    reg_file u0(
                .clk        (sys_clk),
                .wr_en      (wr_en),
                .w_addr     (w_addr),
                .r_addr     (r_addr),
                .w_data     (w_data),
                .r_data     (r_data)
            );


	// -------------------------------------------------------------------------
	// Line In Generator
	// -------------------------------------------------------------------------
	//
	initial begin
        wr_en = 0;

		// Assert for ~100 clocks to avoid a Xilinx AXI VIP reset warning
		#(10*REFCLK_PERIOD);
        w_addr = 0;
        r_addr = 0;
        w_data = 8'h11;

		// Synchronous deassertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_en =  1;
		
        #(10*REFCLK_PERIOD);
        wr_en = 0;
        w_addr = 1;
        w_data = 8'h22;

		// Synchronous deassertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_en = 1;
		
        #(10*REFCLK_PERIOD);
        wr_en = 0;

		// Synchronous deassertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_en = 1;
		w_addr = 2;
        w_data = 8'h33;
        
        #(10*REFCLK_PERIOD);
        wr_en = 0;

		// Synchronous deassertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_en = 1;
		w_addr = 3;
        w_data = 8'h44;
	

		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		r_addr = 0;
		wr_en = 0;
		
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		r_addr = 1;
		wr_en = 0;

		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		r_addr = 2;
		wr_en = 0;
		
	    #(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		r_addr = 3;
		wr_en = 0;
		
		
	end

	initial begin
		$display(" ");
		$display("==========================================================");
		$display("Edge Detect system simulation");
		$display("==========================================================");
		$display(" ");

		
		// Wait
		#(300*REFCLK_PERIOD);
		

		// --------------------------------------------------------------------
		// End simulation
		// --------------------------------------------------------------------
		//
		$display(" ");
		$display("----------------------------------------------------------");
		$display("End simulation");
		$display("----------------------------------------------------------");
		$display(" ");
		$stop(0);
	end


endmodule
