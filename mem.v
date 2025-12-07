`timescale 1ns / 1ps

module mem_stage(
    input  wire        clk,
    input  wire [31:0] ALUResult,
    input  wire [31:0] WriteData,
    input  wire [4:0]  WriteReg,
    input  wire [1:0]  WBControl,
    input  wire        MemWrite,
    input  wire        MemRead,
    input  wire        Branch,
    input  wire        Zero,

    output wire [31:0] ReadData,
    output wire [31:0] ALUResult_out,
    output wire [4:0]  WriteReg_out,
    output wire [1:0]  WBControl_out,
    output wire        PCSrc
);
    // Internal wires
    wire [31:0] mem_read_data;
    wire [31:0] wb_read_data;  

    // Data memory
    data_memory dm (
        .clk       (clk),
        .memwrite  (MemWrite),
        .memread   (MemRead),
        .address   (ALUResult),
        .write_data(WriteData),
        .read_data (mem_read_data)
    );


    assign ReadData = mem_read_data;

    // MEM/WB latch
    mem_wb memwb_reg (
        .clk          (clk),
        .WB_in        (WBControl),
        .ReadData_in  (mem_read_data),
        .ALUResult_in (ALUResult),
        .WriteReg_in  (WriteReg),

        .WB_out       (WBControl_out),
        .ReadData_out (wb_read_data),
        .ALUResult_out(ALUResult_out),
        .WriteReg_out (WriteReg_out)
    );

    // Branch decision: PCSrc = Branch & Zero
    and_gate branch_and_zero (
        .a (Branch),
        .b (Zero),
        .y (PCSrc)
    );

endmodule
