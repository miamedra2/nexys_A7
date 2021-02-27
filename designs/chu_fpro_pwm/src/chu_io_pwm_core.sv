`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2021 01:29:15 PM
// Design Name: 
// Module Name: chu_io_pwm_core
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


module chu_io_pwm_core
    #(parameter W=6, // width (# bits) of output port
                R=10 // # bits of PWM resolution (ie 2^R levels)
    )
    (
     input logic clk,
     input logic reset,
     // slot interface
     input logic cs,
     input logic read,
     input logic write,
     input logic [4:0] addr,
     input logic [31:0] wr_data,
     output logic [31:0] rd_data,
     // external signal
     output logic [W-1:0] pwm_out
    );
    
    // signal declaration
    logic [R:0] duty_2d_reg [W-1:0];
    logic duty_array_en, dvsr_en;
    logic [31:0] q_reg;
    logic [31:0] q_next;
    logic [R-1:0] d_reg;
    logic [R-1:0] d_next;
    logic [R:0] d_ext;
    logic [W-1:0] pwm_reg;
    logic [W-1:0] pwm_next;
    logic tick;
    logic [31:0] dvsr_reg;
    
    //********************************************************
    // wrapping circuit
    //********************************************************
    // decoding
    assign duty_array_en = cs && write && addr[4];
    assign dvsr_en = cs && write && addr==5'b00000;
    // register for divisor
    always_ff @(posedge clk, posedge reset)
        if (reset)
            dvsr_reg <= 0;
        else
            if( dvsr_en )
                dvsr_reg <= wr_data;
    // register file for duty cycles
    always_ff @(posedge clk)
        if(duty_array_en)
            duty_2d_reg[addr[3:0]] <= wr_data[R:0];
            
    //********************************************************
    // multi-bit PWM
    //********************************************************
    always_ff @(posedge clk, posedge reset)
        if(reset) begin
            q_reg <= 0;
            d_reg <= 0;
            pwm_reg <= 0;
        end
        else begin
            q_reg <= q_next;
            d_reg <= d_next;
            pwm_reg <= pwm_next;
        end
    // 'prescale' counter
    assign q_next = (q_reg==dvsr_reg) ? 0 : q_reg + 1;
    assign tick = q_reg==0;
    // duty cycle counter
    assign d_next = (tick) ? d_reg + 1 : d_reg;
    assign d_ext = {1'b0, d_reg};
    // comparison circuit
    generate
        genvar i;
        for (i=0; i<W; i=i+1) begin
            assign pwm_next[i] = d_ext <duty_2d_reg[i];
        end
    endgenerate
    assign pwm_out = pwm_reg;
    //read data not used
    assign rd_data = 32'b0;
    
    
    
endmodule
