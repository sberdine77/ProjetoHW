module unidadeControle
(	input logic clk, reset,
	input logic [5:0] opcode, funct, 
	output logic memWriteOrRead, pcControl, irWrite,
	output logic [2:0] aluControl,
	output logic [2:0] estado);

	
	enum logic [2:0] {
	Reset, //0
	MemoryRead, //1
	WaitMemoryRead, //2
	IRWrite //3
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
			IRWrite: state <= MemoryRead;
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
		endcase
	end
		
	
endmodule: unidadeControle