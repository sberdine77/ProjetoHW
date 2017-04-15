module dataPath (input logic clock, res);
	
	wire [31:0] Pc;
	wire [31:0] ALUOut;
	wire [2:0] ALUControl;
	wire MemRead;
	wire MemWrite;
	wire PCControl;
	wire MDR;
	
	unidadeControle unidadeControle
	(	.clk(clock),
		.reset(res),
		.memRead(MemRead),
		.memWrite(MemWrite),
		.pcControl(PCControl),
		.aluControl(ALUControl)
		);
	
endmodule: dataPath