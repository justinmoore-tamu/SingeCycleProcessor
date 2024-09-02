`define OPCODE_ANDREG 11'b?0001010???
`define OPCODE_ORRREG 11'b?0101010???
`define OPCODE_ADDREG 11'b?0?01011???
`define OPCODE_SUBREG 11'b?1?01011???

`define OPCODE_ADDIMM 11'b?0?10001???
`define OPCODE_SUBIMM 11'b?1?10001???

`define OPCODE_MOVZ   11'b110100101??

`define OPCODE_B      11'b?00101?????
`define OPCODE_CBZ    11'b?011010????

`define OPCODE_LDUR   11'b??111000010
`define OPCODE_STUR   11'b??111000000

module control(
    output reg reg2loc,
    output reg alusrc,
    output reg mem2reg,
    output reg regwrite,
    output reg memread,
    output reg memwrite,
    output reg branch,
    output reg uncond_branch,
    output reg [3:0] aluop,
    output reg [2:0] signop, // CHANGED
    input [10:0] opcode
);

always @(*)
begin
    casez (opcode)

        /* Add cases here for each instruction your processor supports */
	// control signals:
        //      000: I type [21:10]
        //      001: D type [20:12]
        //      010: B type [25:0]
        //      011: CBZ type [23:5]  // is zero extended
	//      1??: MOVZ type [20:5] 
	//      	100 0 bit shift
	//      	101 16 bit shift
	//      	110 32 bit shift
	//      	111 48 bit shift

	`OPCODE_LDUR: begin
		{reg2loc, uncond_branch, branch, memread, mem2reg, memwrite, alusrc, regwrite, aluop, signop} <= {1'bx, 1'b0,1'b0,1'b1,1'b1,1'b0,1'b1,1'b1,4'b0010, 3'b001};
	end
	`OPCODE_STUR: begin
		{reg2loc, uncond_branch, branch, memread, mem2reg, memwrite, alusrc, regwrite, aluop, signop} <= {1'b1,1'b0,1'b0,1'b0,1'bx,1'b1,1'b1,1'b0,4'b0010, 3'b001};
	end
	`OPCODE_ADDREG: begin
		{reg2loc, uncond_branch, branch, memread, mem2reg, memwrite, alusrc, regwrite, aluop, signop} <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,4'b0010, 3'bxxx};
	end
	`OPCODE_ADDIMM: begin
		{reg2loc, uncond_branch, branch, memread, mem2reg, memwrite, alusrc, regwrite, aluop, signop} <= {1'bx,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,4'b0010, 3'b000};
	end
	`OPCODE_SUBREG: begin
		{reg2loc, uncond_branch, branch, memread, mem2reg, memwrite, alusrc, regwrite, aluop, signop} <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,4'b0110, 3'bxxx};
	end
	`OPCODE_SUBIMM: begin
		{reg2loc, uncond_branch, branch, memread, mem2reg, memwrite, alusrc, regwrite, aluop, signop} <= {1'bx,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,4'b0110, 3'b000};
	end
	`OPCODE_ANDREG: begin
		{reg2loc, uncond_branch, branch, memread, mem2reg, memwrite, alusrc, regwrite, aluop, signop} <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,4'b0000, 3'bxxx};
	end
	`OPCODE_ORRREG: begin
		{reg2loc, uncond_branch, branch, memread, mem2reg, memwrite, alusrc, regwrite, aluop, signop} <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,4'b0001, 3'bxxx};
	end
	`OPCODE_B: begin
		{reg2loc, uncond_branch, branch, memread, mem2reg, memwrite, alusrc, regwrite, aluop, signop} <= {1'bx,1'b1,1'bx,1'b0,1'bx,1'b0,1'bx,1'b0,4'bxxxx, 3'b010};
	end
	`OPCODE_CBZ: begin
		{reg2loc, uncond_branch, branch, memread, mem2reg, memwrite, alusrc, regwrite, aluop, signop} <= {1'b1,1'b0,1'b1,1'b0,1'bx,1'b0,1'b0,1'b0,4'b0111, 3'b011};
	end
	`OPCODE_MOVZ: begin
		{reg2loc, uncond_branch, branch, memread, mem2reg, memwrite, alusrc, regwrite, aluop, signop} <= {1'bx,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,4'b0111, 3'b100 };
	end


        default:
        begin
            reg2loc       <= 1'bx;
            alusrc        <= 1'bx;
            mem2reg       <= 1'bx;
            regwrite      <= 1'b0;
            memread       <= 1'b0;
            memwrite      <= 1'b0;
            branch        <= 1'b0;
            uncond_branch <= 1'b0;
            aluop         <= 4'bxxxx;
            signop        <= 2'bxx;
        end
    endcase
end

endmodule

