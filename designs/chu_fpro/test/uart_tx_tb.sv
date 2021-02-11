`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2021 06:08:44 PM
// Design Name: 
// Module Name: uart_tx_tb
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


module uart_tx_tb;


	// Local parameters
	// ------------------------------------------------------------------------

	localparam real REFCLK_FREQUENCY      = 100.00e6; 


	// Clock periods
	localparam time REFCLK_PERIOD      = (1.0e9/REFCLK_FREQUENCY)*1ns;
	
	localparam DATABIT     = 8;
	
	localparam TICK_STOPBIT   = 16;
	
	

	// -------------------------------------------------------------------------
	// Internal Signals
	// -------------------------------------------------------------------------
	//
	// Clock and reset
	logic sys_clk, reset;
	
    // Logic
    logic [10:0] dvsr;
    
    logic tx_start, tx_done_tick;
    
    // Output Logic
    logic tick, tx;
    
    logic [7:0] din;
    
    // -------------------------------------------------------------------------
	// Clk generator
	// -------------------------------------------------------------------------
	//
	initial begin
		sys_clk = 1'b0;
		forever begin
			#(REFCLK_PERIOD/2) sys_clk = ~sys_clk;
		end
	end
	
	
	// -------------------------------------------------------------------------
	// Restarts uart_tx after tx_done_tick goes high
	// -------------------------------------------------------------------------
	//
	initial begin
	   
	   din = 8'hAA;
	   
	   forever begin
	   @(sys_clk)
	       if(tx_done_tick) begin
	       
	           // start transmit 
		      #(20*REFCLK_PERIOD);
		      @(posedge sys_clk);
		      tx_start = 1'b1;
		      
		      #(20*REFCLK_PERIOD);
		      @(posedge sys_clk);
		      tx_start = 1'b0;
		      end
        end
    end
	       
	
    // -------------------------------------------------------------------------
	// Reset generator and RX data
	// -------------------------------------------------------------------------
	//
	initial begin
		reset = 1'b0;
		
		
		dvsr = 10'h2;
		
		// Synchronous assertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		reset = 1'b1;
		
		// Synchronous deassertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		reset = 1'b0;
		
		// start transmit 
		#(20*REFCLK_PERIOD);
		@(posedge sys_clk);
		tx_start = 1'b1;
		
		#(20*REFCLK_PERIOD);
		@(posedge sys_clk);
		tx_start = 1'b0;
		
	end
	
	baud_gen u0
	(
	   .clk    (sys_clk),
	   .reset  (reset),
	   .dvsr   (dvsr),
	   .tick   (tick)
	   );
	   

    uart_tx #(.DBIT(DATABIT), .SB_TICK(TICK_STOPBIT)) u1
    (
        .clk            (sys_clk),
        .reset          (reset),
        .tx_start       (tx_start),
        .s_tick         (tick),
        .din            (din),
        .tx_done_tick   (tx_done_tick),
        .tx             (tx)
    );

	// -------------------------------------------------------------------------
	// RX In Generator
	// -------------------------------------------------------------------------
	//

	initial begin
		$display(" ");
		$display("==========================================================");
		$display("RX Generator simulation");
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
		
		end
		
endmodule