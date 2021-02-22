`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2021 09:42:02 AM
// Design Name: 
// Module Name: pwm_basic_tb
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


module pwm_basic_tb;


	// ------------------------------------------------------------------------
	// Local parameters
	// ------------------------------------------------------------------------

	localparam real REFCLK_FREQUENCY      = 33.00e6; 


	// Clock periods
	localparam time REFCLK_PERIOD      = (1.0e9/REFCLK_FREQUENCY)*1ns;
	
	localparam R = 8; // PWM bit resolution

	// -------------------------------------------------------------------------
	// Internal Signals
	// -------------------------------------------------------------------------
	//
	// Clocks
	logic sys_clk;
	logic sys_reset;
	
	// Logic
	logic [R-1:0] duty;
	logic pwm_out;
	
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

    pwm_basic #(.R(R)) u0
            (
                .clk        (sys_clk),
                .reset      (sys_reset),
                .duty       (duty),
                .pwm_out    (pwm_out)
            );


	// -------------------------------------------------------------------------
	// Reset Generator
	// -------------------------------------------------------------------------
	//
	initial begin
	
	sys_reset = 1;
	duty = 8'h7F;
  
    #(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		sys_reset = 0;
	
	end

	initial begin
		$display(" ");
		$display("==========================================================");
		$display("Basic PWM simulation");
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
