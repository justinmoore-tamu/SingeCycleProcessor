`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define PassB 4'b0111


module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
    
    parameter n = 64;

    output  [n-1:0] BusW;
    input   [n-1:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output Zero;
    
    reg     [n-1:0] BusW;
    
    always @(ALUCtrl or BusA or BusB) begin
        case(ALUCtrl)
            `AND: begin
                BusW = BusA & BusB;
		// Zero = BusW ? 1 : 0;
		//if (BusW == 0)  Zero = 0;
		//else Zero = 1;
            end
	    `OR: begin
		BusW = BusA | BusB;
		//if (BusW == 0)  Zero = 0;
                //else Zero = 1;
            end
	    `ADD: begin
		BusW = BusA + BusB; 
		//if (BusW == 0)  Zero = 0;
                //else Zero = 1;
	    end
	    `SUB: begin
		BusW = BusA - BusB;
		//if (BusW == 0)  Zero = 0;
                //else Zero = 1;
            end
	    `PassB: begin
		BusW = BusB;
		//if (BusW == 0)  Zero = 0;
                //else Zero = 1;
	    end
	    default: BusW = 0; //assign Zero = 0; end// uh oh, somethign went wrong
        endcase
    end
	
    
    assign Zero = (BusW==0) ? 1'b1 : 1'b0 ;
   
    //if (BusW == 0) assign Zero = 1;
    //else assign Zero = 0;
endmodule
