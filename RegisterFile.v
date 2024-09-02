`timescale 1ns / 1ps
module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
	// define output registers
	output [63:0] BusA, BusB;

	// define input wires
	input [63:0] BusW;  // value to be written to reg[RW]
	input [4:0] RA, RB, RW; // 5 bit register location values
	input wire RegWr, Clk; // 1 bit clock and Register Write signals

	// define number and width of registers
	reg [63:0] registers [31:0];  // defines 32 registers, each 64 bits wide
	
	// initial block to define registers[31] as 0
	//initial begin
	//	registers[31] = 0;  // register 31 must always be 0
	//end
	// on every negedge of Clock, if RegWr is enabled, update reg[RW]
	// and also assert that registers[31] is 0 
	always@(negedge Clk) begin
		if (RegWr && RW != 31) // can probs update this to make sure RW !== 31
			registers[RW] <= BusW;
			// registers[31] = 0;
	end
	
	// basic function of a register file
	// assign BusA with register value at RA
	// assign BusB with register value at RB
	/*	
	always@ (*) begin
		#2 BusA = registers[RA];
        	#2 BusB = registers[RB];
	end */

	assign #2 BusA = (RA == 31) ? 64'b0 : registers[RA];
	assign #2 BusB = (RB == 31) ? 64'b0 : registers[RB];
	
endmodule
