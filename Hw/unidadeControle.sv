module unidadeControle
(	input logic clk, reset,
	input logic [5:0] opcode, 
	input logic [5:0] funct, 
	output logic memWriteOrRead,
	output logic pcControl,
	output logic pcCond,
	output logic [1:0] origPC,
	output logic bneORbeq,
	output logic irWrite,
	output logic writeA,
	output logic writeB,
	output logic aluSrcA,
	output logic aluOutControl,
	output logic [1:0]  aluSrcB,
	output logic [2:0] aluControl,
	output logic [2:0] estado);

	
	enum logic [2:0] {
	Reset, //0
	MemoryRead, //1
	WaitMemoryRead, //2
	IRWrite, //3
	Decode, //4
	Add, //5
	And, //6
	Sub, //7
	Xor, //8
	Break, //9
	Nop, //10
	WriteRegAlu, //11
	Beq,	//12
	Bne		//13
	} state;
	
	initial state <= Reset;
	
	always_ff@(posedge clk or posedge reset)
	begin
		if(reset) state <= Reset;
		else
		begin
			case(state)
			Reset: state <= MemoryRead;
			MemoryRead: state <= WaitMemoryRead;
			WaitMemoryRead: state <= IRWrite;
			IRWrite: state <= Decode;
			Decode:
			begin
				case(opcode):
					6'h0:
					begin
						case(funct)
						6'h20: state <=		//add
						6'h24: state <= 	//and
						6'h22: state <= 	//sub
						6'h26: state <=		//xor
						6'hd: state <=		//break
						6'h0: state <=		//nop
						endcase
					end
					6'h4: state <= Beq;			//beq
					6'h5: state <= Bne;			//bne
					6'h23: state <=			//lw
					6'h2b: state <=			//sw
					6'hf: state <=			//lui
					6'h2: state <=			//jump
				endcase
			end
			Beq: state <= MemoryRead;
			Bne: state <= MemoryRead;
			endcase
		end
	end
	
	always_comb
	begin
		case(state)
		Reset:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b0;
			irWrite = 1'b1;
			aluControl = 3'b000;
			estado <= state;
		end
		MemoryRead:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b0;
			irWrite = 1'b1;
			aluControl = 3'b001;
			estado <= state;
		end
		WaitMemoryRead:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b0;
			irWrite = 1'b1;
			aluControl = 3'b001;
			estado <= state;
		end
		IRWrite:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b1;
			irWrite = 1'b1;
			aluControl = 3'b001;
			estado <= state;
		end
		Decode:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b0;
			irWrite = 1'b0;
			aluControl = 3'b001;
			aluSrcA = 1'b0;
			aluSrcB = 2'b11;
			aluOutControl = 1'b1;
			writeA = 1'b1;
			writeB = 1'b1;
			estado <= state;
		end
		Beq:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b0;
			pcCond = 1'b1;
			origPC = 2'b01;
			irWrite = 1'b0;
			aluControl = 3'b010;
			aluSrcA = 1'b1;
			aluSrcB = 2'b00;
			aluOutControl = 1'b0;
			writeA = 1'b0;
			writeB = 1'b0;
			bneORbeq = 1'b1;
			estado <= state;
		end
		Bne:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b0;
			pcCond = 1'b1;
			origPC = 2'b01;
			irWrite = 1'b0;
			aluControl = 3'b010;
			aluSrcA = 1'b1;
			aluSrcB = 2'b00;
			aluOutControl = 1'b0;
			writeA = 1'b0;
			writeB = 1'b0;
			bneORbeq = 1'b0;
			estado <= state;
		end

		endcase
	end
		
	
endmodule: unidadeControle