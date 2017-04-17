module dataPath 
(	input logic clock, res,
	output logic [31:0] PCOut, AluOutOut, MemDataOutOut,
	output logic [2:0] StateOut,
	output logic WriteOrReadOut, PCControlOut
	);
	
	logic [31:0] Pc;
	logic [31:0] ALUOut;
	logic [2:0] ALUControl;
	logic WriteOrRead;
	logic PCControl;
	logic [31:0] MemDataOut;
	logic [2:0] State;
	logic MDR;
	
	unidadeControle unidadeControle
	(	.clk(clock),
		.reset(res),
		.memWriteOrRead(WriteOrRead),
		.pcControl(PCControl),
		.aluControl(ALUControl),
		.estado(State)
		);
	
	Ula32 Ula
	(	.A(Pc),
		.B(3'b100),
		.Seletor(ALUControl),
		.S(ALUOut)
		);
	
	Registrador PC
	(	.Clk(clock),
		.Reset(res),
		.Load(PCControl),
		.Entrada(ALUOut),
		.Saida(Pc)
		);
	
	Memoria Memoria
	(	.Address(Pc),
		.Clock(clock),
		.Wr(WriteOrRead),
		.Dataout(MemDataOut)
		);

	assign PCOut = Pc;
	assign AluOutOut = ALUOut;
	assign StateOut = State;
	assign WriteOrReadOut = WriteOrRead;
	assign PCControlOut = PCControl;
	assign MemDataOutOut = MemDataOut;
		
endmodule: dataPath