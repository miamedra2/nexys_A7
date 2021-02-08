`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2021 12:49:20 PM
// Design Name: 
// Module Name: baud_gen_tb
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


module baud_gen_tb;

	// Local parameters
	// ------------------------------------------------------------------------

	localparam real REFCLK_FREQUENCY      = 33.00e6; 


	// Clock periods
	localparam time REFCLK_PERIOD      = (1.0e9/REFCLK_FREQUENCY)*1ns;
	

	// -------------------------------------------------------------------------
	// Internal Signals
	// -------------------------------------------------------------------------
	//
	// Clock and reset
	logic sys_clk, reset;
	
    // Logic
    logic [10:0] dvsr;
    // Output Logic
    logic tick;
    
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
	// Reset generator
	// -------------------------------------------------------------------------
	//
	initial begin
		reset = 1'b0;
		dvsr = 10'h3;
		
		// Synchronous assertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		reset = 1'b1;
		
		// Synchronous deassertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		reset = 1'b0;
		
	end
	
	baud_gen u0
	(
	   .clk    (sys_clk),
	   .reset  (reset),
	   .dvsr   (dvsr),
	   .tick   (tick)
	   );

	// -------------------------------------------------------------------------
	// Line In Generator
	// -------------------------------------------------------------------------
	//


	initial begin
		$display(" ");
		$display("==========================================================");
		$display("Baud Generator simulation");
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

