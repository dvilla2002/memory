`timescale 1ns / 1ps
/*
MEM/WB latch:
Holds WB control, memory read data, ALU result, and destination register.
*/
module mem_wb(
    input  wire        clk,
    input  wire [1:0]  WB_in,
    input  wire [31:0] ReadData_in,
    input  wire [31:0] ALUResult_in,
    input  wire [4:0]  WriteReg_in,

    output reg  [1:0]  WB_out,
    output reg  [31:0] ReadData_out,
    output reg  [31:0] ALUResult_out,
    output reg  [4:0]  WriteReg_out
);
    initial begin
        WB_out        = 2'd0;
        ReadData_out  = 32'd0;
        ALUResult_out = 32'd0;
        WriteReg_out  = 5'd0;
    end

    always @(posedge clk) begin
        WB_out        <= WB_in;
        ReadData_out  <= ReadData_in;
        ALUResult_out <= ALUResult_in;
        WriteReg_out  <= WriteReg_in;
    end
endmodule
