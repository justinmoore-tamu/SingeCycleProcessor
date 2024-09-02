`timescale 1ns / 1ps
module SignExtender(BusImm, Imm26, Ctrl);
	output reg [63:0] BusImm;     // 64-bit extended immediate output
	input wire [25:0] Imm26;   // instruction bits 25-0
	input wire [2:0] Ctrl; // 2 bit control signal
	//reg BusImm;
	
       	// control signals:
        //      000: I type [21:10]
        //      001: D type [20:12]
        //      010: B type [25:0]
        //      011: CBZ type [23:5]  // is zero extended
        //      1??: MOVZ type [20:0]
        //              100 0 bit shift
        //              101 16 bit shift
        //              110 32 bit shift
        //              111 48 bit shift

	// define internal wires
	always@(*) begin
	case (Ctrl)
		3'b000: BusImm <= { {52{1'b0}}, Imm26[21:10] } ;
		3'b001: BusImm <= { {55{Imm26[20]}}, Imm26[20:12] } ;
		3'b010: BusImm <= { {38{Imm26[25]}}, Imm26[25:0] } ; // MAKE SURE TO SHIFT BY 2 AT SOME POINT
		3'b011: BusImm <= { {45{Imm26[23]}}, Imm26[23:5] } ;
		
		//3'b100: BusImm <= { {48{1'b0}}, Imm26[20:5] };
		//3'b101: BusImm <= { {32{1'b0}}, Imm26[20:5], {16{1'b0}} };
		//3'b110: BusImm <= { {16{1'b0}}, Imm26[20:5], {32{1'b0}} };
		//3'b111: BusImm <= { Imm26[20:5], {48{1'b0}} };
		3'b100: begin
			case (Imm26[22:21])
				2'b00: BusImm <= { {48{1'b0}}, Imm26[20:5] };
				2'b01: BusImm <= { {32{1'b0}}, Imm26[20:5], {16{1'b0}} };
				2'b10: BusImm <= { {16{1'b0}}, Imm26[20:5], {32{1'b0}} };
				2'b11: BusImm <= { Imm26[20:5], {48{1'b0}} };
			endcase
		end

		default: BusImm <= 0 ; // this should not be reached
	endcase
        end
endmodule
