module dataPath 
(	input logic clock, res,
	output logic [31:0] PCOut, AluOutOut, MemDataOutOut,
	output logic [2:0] StateOut,
	output logic WriteOrReadOut, PCControlOut, IRWrite
	);
	
	logic [31:0] wPc;
	logic [1:0] wPCSource;
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
	logic wRegALUControl;
	logic wRegA;
	logic wRegB;
	logic [31:0] wA;
	logic [31:0] wB;
	logic [31:0] wAOut;
	logic [31:0] wBOut;
	logic [31:0] wRegAOut;
	logic [31:0] wRegBOut;	
	logic wAluSrcA;
	logic [1:0] wAluSrcB;
	logic wMemToReg;
	logic [31:0] wWriteData;
	logic wRegDst;
	logic wRegWrite;
	
	assign wfunct = wInstrucao15_0[5:0];
	
	unidadeControle unidadeControle
	(	.clk(clock),
		.reset(res),
		.opcode(wInstrucao31_26),
		.funct(wfunct),
		.memWriteOrRead(wWriteOrRead),
		.pcControl(wPCControl),
		.irWrite(wIRWrite),
		.writeA(wRegA),
		.writeB(wRegB),
		.aluSrcA(wAluSrcA),
		.aluSrcB(wAluSrcB),
		.aluControl(wALUControl),
		.regAluControl(wRegALUControl),
		.regDst(wRegDst),
		.regWrite(wRegWrite),
		.memToReg(wMemToReg),
		.estado(wState)
		);
		
	Ula32 Ula
	(	.A(wAOut),
		.B(wBOut),
		.Seletor(wALUControl),
		.S(wALU)
		);
		
	Banco_reg BancoReg
	(
			.Clk(clock),
			.Reset(res),
			.RegWrite(wRegWrite),
			.ReadReg1(wInstrucao25_21),
			.ReadReg2(wInstrucao20_16),
			.WriteReg(wWriteReg),
			.WriteData(wWriteData),
			.ReadData1(wA),
			.ReadData2(wB)
	);
	
	Registrador PC
	(	.Clk(clock),
		.Reset(res),
		.Load(wPCControl),
		.Entrada(wALUOut),
		.Saida(wPc)
		);
		
	Registrador A
	(	.Clk(clock),
		.Reset(res),
		.Load(wRegA),
		.Entrada(wA),
		.Saida(wRegAOut)
		);
			
	Registrador B
	(	.Clk(clock),
		.Reset(res),
		.Load(wRegB),
		.Entrada(wB),
		.Saida(wRegBOut)
		);	
		
	Registrador ALUOut
	(	.Clk(clock),
		.Reset(res),
		.Load(wRegALUControl),
		.Entrada(wALU),
		.Saida(wALUOut)
		);
		
	MuxPC MuxPc
	(	.PC(wPc),
		.AluOut(wALUOut),
		.IorD(wIorD),
		.Address(wAddress)
	);
	
	MuxInsReg MuxInsReg
	(
		.Inst20_16(wInstrucao20_16), 
		.Funct(wfunct),
		.RegDst(wRegDst),
		.WriteReg(wWriteReg)
	);
	
	MuxDataWrite MuxDataWrite
	(
		.ALUOutReg(wALUOut), 
		.MDR(wMemDataOut),
		.MemtoReg(wMemToReg),
		.WriteDataMem(wWriteData)
);
	
	MuxA MuxA
	(
		.PC(wPc),
		.A(wAOut),
		.ALUSrcA(wAluSrcA),
		.AOut(wAOut)
	);
	
	MuxB MuxB
	(	.B(wBOut), 
		.signalExt(), //I-TYPE WIRE
		.desloc_esq(), //I-TYPE WIRE
		.ALUSrcB(wAluSrcA),
		.BOut(wBOut)
	);
	
	MuxSaidaALU MuxSaidaAlu
	(	.ALU(wALU), 
		.ALUOut(wALUOut),
		.RegDesloc(wRegDesloc), // nome fio desloc jump
		.PCSource(wPCSource),
		.inPC(winPC)
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