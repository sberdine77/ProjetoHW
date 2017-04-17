module MuxDataWrite
(
	input logic [31:0] ALUOutReg, 
	input logic [31:0] MDR,
	input logic MemtoReg,
	output logic [31:0] WriteDataMem
);

always_comb
	begin
		case (MemtoReg)
		1'b0: WriteDataMem <= ALUOutReg;
		1'b1: WriteDataMem <= MDR;
		endcase
	end
 
endmodule: MuxDataWrite