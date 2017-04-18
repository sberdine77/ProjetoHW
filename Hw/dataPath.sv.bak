module dataPath 
(	input logic clock, res,
	output logic [31:0] PCOut, AluOutOut, MemDataOutOut,
	output logic [2:0] StateOut,
	output logic WriteOrReadOut, PCControlOut, IRWrite
	);
	
	logic [31:0] wPc;
	logic [31:0] wALUOut;
	logic [31:0] wAddress;
	logic [2:0] wALUControl;
	logic wWriteOrRead;
	logic wPCControl;
	logic [31:0] wMemDataOut;
	logic [2:0] wState;
	logic wIRWrite;
	logic [5:0] wInstrucao31_26;
	logic [4:0] wInstrucao25_21;
	logic [4:0] wInstrucao20_16;
	logic [16:0] wInstrucao15_0;
	logic wIorD;
	logic [5:0] wfunct;
	
	assign wfunct = wInstrucao15_0[5:0];
	
	unidadeControle unidadeControle
	(	.clk(clock),
		.reset(res),
		.opcode(wInstrucao31_26),
		.funct(wfunct),
		.memWriteOrRead(wWriteOrRead),
		.pcControl(wPCControl),
		.irWrite(wIRWrite),
		.aluControl(wALUControl),
		.estado(wState)
		);
	
	Ula32 Ula
	(	.A(wPc),
		.B(3'b100),
		.Seletor(wALUControl),
		.S(wALUOut)
		);
		
	
	Registrador PC
	(	.Clk(clock),
		.Reset(res),
		.Load(wPCControl),
		.Entrada(wALUOut),
		.Saida(wPc)
		);
		
	MuxPC MuxPc
	(	.PC(wPc),
		.AluOut(wALUOut),
		.IorD(wIorD),
		.Address(wAddress)
	);
	
	Instr_Reg IR
	(	.Clk(clock),
		.Reset(res),
		.Load_ir(wIRWrite),
		.Entrada(wMemDataOut),
		.Instr31_26(wInstrucao31_26),
		.Instr25_21(wInstrucao25_21),
		.Instr20_16(wInstrucao20_16),
		.Instr15_0(wInstrucao15_0)
	);
	
	Memoria Memoria
	(	.Address(wAddress),
		.Clock(clock),
		.Wr(wWriteOrRead),
		.Dataout(wMemDataOut)
		);

	assign PCOut = wPc;
	assign AluOutOut = wALUOut;
	assign StateOut = wState;
	assign WriteOrReadOut = wWriteOrRead;
	assign PCControlOut = wPCControl;
	assign MemDataOutOut = wMemDataOut;
		
endmodule: dataPath