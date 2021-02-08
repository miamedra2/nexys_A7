`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2021 12:48:45 PM
// Design Name: 
// Module Name: reg_file
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


module reg_file
    #(
    parameter   DATA_WIDTH = 8,     // number of bits
                ADDR_WIDTH = 2      // number od address bits
    )
    (
    input logic clk,
    input logic wr_en,
    input logic     [ADDR_WIDTH-1:0] w_addr,
    input logic     [ADDR_WIDTH-1:0] r_addr,
    input logic     [DATA_WIDTH-1:0] w_data,
    output logic    [DATA_WIDTH-1:0] r_data
    );
    
    // signal declaratio
    logic [DATA_WIDTH-1:0] array_reg [0:2**ADDR_WIDTH-1];
    
    // body
    // write operation
    always_ff @(posedge clk)
        if(wr_en)
            array_reg[w_addr] <= w_data;
    // read operation
    assign r_data = array_reg[r_addr];
endmodule
