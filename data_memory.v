`timescale 1ns / 1ps
/*
Data Memory:
- Writes on MemWrite == 1 at posedge clk
- Reads on MemRead == 1 at posedge clk into read_data
*/
module data_memory(
    input  wire        clk,
    input  wire        memwrite,
    input  wire        memread,
    input  wire [31:0] address,
    input  wire [31:0] write_data,
    output reg  [31:0] read_data
);
    reg [31:0] mem [0:31]; // 32 words of 32 bits

    integer i;
    initial begin
        // Initialize memory to 0 for clean waveforms
        for (i = 0; i < 32; i = i + 1)
            mem[i] = 32'd0;

        // You can add some test values if you like, e.g.:
        // mem[0] = 32'hBBBBBBBB;
        // mem[4] = 32'hAAAAAAAA;
    end

    always @(posedge clk) begin
        if (memwrite) begin
            mem[address[4:0]] <= write_data;
        end
        if (memread) begin
            read_data <= mem[address[4:0]];
        end
    end
endmodule
