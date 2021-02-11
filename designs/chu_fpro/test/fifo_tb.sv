`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2021 10:20:11 AM
// Design Name: 
// Module Name: fifo_tb
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


module fifo_tb;
// ------------------------------------------------------------------------
	// Local parameters
	// ------------------------------------------------------------------------

	localparam real REFCLK_FREQUENCY      = 33.00e6; 


	// Clock periods
	localparam time REFCLK_PERIOD      = (1.0e9/REFCLK_FREQUENCY)*1ns;
	
	localparam DATA_WIDTH = 8; // number of bits
	localparam ADDR_WIDTH = 4; // number of address bits

	// -------------------------------------------------------------------------
	// Internal Signals
	// -------------------------------------------------------------------------
	//
	// Clock and reset
	logic sys_clk, reset;
	
    //ogic
    logic wr_en;
    logic read_en;
    logic    [7:0]   w_data;
    logic    [7:0]   r_data;
    
    logic empty, full;
    

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
	
    // -------------------------------------------------------------------------
	// Reset generator
	// -------------------------------------------------------------------------
	//
	initial begin
		reset = 1'b0;
		
		// Synchronous assertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		reset = 1'b1;
		
		// Synchronous deassertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		reset = 1'b0;
		
	end

        fifo #( .DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) u0   
            (
                .clk        (sys_clk),
                .reset      (reset),
                .rd         (read_en),
                .wr         (wr_en),
                .w_data     (w_data),
                .empty      (empty),
                .full       (full),
                .r_data     (r_data)
            );


	// -------------------------------------------------------------------------
	// Line In Generator
	// -------------------------------------------------------------------------
	//
	initial begin
        wr_en = 0;
        read_en = 0;

		// Assert for ~100 clocks to avoid a Xilinx AXI VIP reset warning
		#(30*REFCLK_PERIOD);
		@(posedge sys_clk);

        w_data = 8'h11;
        wr_en = 1;
        
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        wr_en = 0;

		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_en =  1;
		w_data = 8'h22;
		
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        wr_en = 0;
		
		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_en =  1;
		w_data = 8'h33;
		
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        wr_en = 0;
        
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        read_en = 1;
        
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        read_en = 0;
        
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        read_en = 1;
        
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        read_en = 0;
        
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        read_en = 1;
        
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        read_en = 0;
        
        #(30*REFCLK_PERIOD);
		@(posedge sys_clk);

        w_data = 8'h11;
        wr_en = 1;
        
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        wr_en = 0;

		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_en =  1;
		w_data = 8'h22;
		
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        wr_en = 0;
		
		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_en =  1;
		w_data = 8'h33;
		
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        wr_en = 0;
        
        #(30*REFCLK_PERIOD);
		@(posedge sys_clk);
        w_data = 8'h44;
        wr_en = 1;
        
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        wr_en = 0;

		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_en =  1;
		w_data = 8'h55;
		
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        wr_en = 0;
		
		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_en =  1;
		w_data = 8'h66;
		
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        wr_en = 0;

        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        read_en = 1;
        
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        read_en = 0;
        
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        read_en = 1;
        
        #(1*REFCLK_PERIOD);
		@(posedge sys_clk);
        read_en = 0;
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
