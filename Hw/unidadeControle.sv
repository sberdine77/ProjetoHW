module unidadeControle
(	input logic clk, reset,
	input logic [5:0] opcode, 
	input logic [5:0] funct, 
	output logic memWriteOrRead,
	output logic pcControl,
	output logic irWrite,
	output logic writeA,
	output logic writeB,
	output logic aluSrcA,
	output logic aluOutControl,
	output logic [1:0] aluSrcB,
	output logic [2:0] aluControl,
	output logic regAluControl,
	output logic regDst,
	output logic regWrite,
	output logic [1:0] memToReg,
	output logic [5:0] estado);

	
	enum logic [5:0] {
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
	WriteRegAlu //11
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
				case(opcode)
					6'h0:
					begin
						case(funct)
						6'h20: state <=	Add;		//add
						6'h24: state <= And;		//and
						6'h22: state <= Sub;		//sub
						6'h26: state <=	Xor;		//xor
						6'hd: state <= Break;		//break
						6'h0: state <= Nop;			//nop
						endcase
					end
					//6'h4: state <=			//beq
					//6'h5: state <=			//bne
					//6'h23: state <=			//lw
					//6'h2b: state <=			//sw
					//6'hf: state <=			//lui
					//6'h2: state <=			//jump
				endcase
				state <= MemoryRead;
			end
			
			Add: state <= WriteRegAlu;
			And: state <= WriteRegAlu;
			Sub: state <= WriteRegAlu;
			Xor: state <= WriteRegAlu;
			Break: state <= Break;
			Nop: state <= MemoryRead;
			WriteRegAlu: state <= MemoryRead;
			
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
		Add:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b0;
			irWrite = 1'b0;
			
			aluControl = 3'b001;
			aluSrcA = 1'b1;
			aluSrcB = 2'b00;
			writeA = 1'b0;
			writeB = 1'b0;
			regAluControl = 1'b1;
			estado <= state;
		end
		And:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b0;
			irWrite = 1'b0;
			
			aluControl = 3'b011;
			aluSrcA = 1'b1;
			aluSrcB = 2'b00;
			writeA = 1'b0;
			writeB = 1'b0;
			regAluControl = 1'b1;
			estado <= state;
		end
		Sub:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b0;
			irWrite = 1'b0;
			
			aluControl = 3'b010;
			aluSrcA = 1'b1;
			aluSrcB = 2'b00;
			writeA = 1'b0;
			writeB = 1'b0;
			regAluControl = 1'b1;
			estado <= state;
		end
		Xor:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b0;
			irWrite = 1'b0;
			
			aluControl = 3'b110;
			aluSrcA = 1'b1;
			aluSrcB = 2'b00;
			writeA = 1'b0;
			writeB = 1'b0;
			regAluControl = 1'b1;
			estado <= state;
		end
		Break: 
		begin			
			estado <= state;
		end
		Nop:
		begin			
			estado <= state;
		end
		WriteRegAlu:
		begin
			regDst = 1'b1;
			regWrite = 1'b1;
			memToReg = 2'b00;
			estado <= state;
		end
		endcase
	end
		
	
endmodule: unidadeControle