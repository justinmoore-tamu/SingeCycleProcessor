`timescale 1ns /1ps
module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
       input [63:0] CurrentPC, SignExtImm64; 
       input Branch, ALUZero, Uncondbranch; 
       output [63:0] NextPC; 
       /* write your code here */ 
       // define input wires and registers
	wire CurrentPC, SignExtImm64;
	wire Branch, ALUZero, Uncondbranch;
	reg NextPC;

	// behavior model to calculate the next PC value 
	// given the given input values
	always@(*) begin    // idk what will drive this block TODO
		// if the unconditional flag is set, update PC
		// MAKE SURE TO Right Shift by 2 since I don't to that in the
		// sign extender module
		if (Uncondbranch) NextPC <= CurrentPC + (SignExtImm64 << 2);
		//
		// The branch flag being set means that a CBZ instruction is
		// being performed, so Branch and ALUZero must be asserted in
		// order to branch
		else if(Branch && ALUZero) NextPC <= CurrentPC + (SignExtImm64 << 2);
		else NextPC <= CurrentPC + 4;
	end  //end always@

endmodule
