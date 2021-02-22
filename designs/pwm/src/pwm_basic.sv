`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2021 09:28:42 AM
// Design Name: 
// Module Name: pwm_basic
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


module pwm_basic
    #(parameter R=10) // # bits of PWM resolution (ie 2**R levels)
    (
        input logic clk,
        input logic reset,
        input logic [R-1:0] duty,
        output logic pwm_out
    );
    
    //declarations
    logic [R-1:0] d_reg, d_next;
    logic pwm_reg, pwm_next;
    
    // body
    always_ff @(posedge clk, posedge reset)
        if(reset) begin
            d_reg <= 0;
            pwm_reg <= 0;
        end
        else begin
            d_reg <= d_next;
            pwm_reg <= pwm_next;
        end
        
    // duty cycle counter
    assign d_next = d_reg + 1;
    // comparison circuit
    assign pwm_next = d_reg < duty;
    assign pwm_out = pwm_reg;
    
    
    
endmodule
