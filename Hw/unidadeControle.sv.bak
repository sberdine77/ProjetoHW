module unidadeControle
(	input logic clk, reset, 
	output logic memWriteOrRead, pcControl, 
	output logic [2:0] aluControl,
	output logic [2:0] estado);

	
	enum logic [2:0] {
	Reset, //0
	MemoryRead, //1
	WaitMemoryRead, //2
	PCWrite //3
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
			WaitMemoryRead: state <= PCWrite;
			PCWrite: state <= MemoryRead;
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
			aluControl = 3'b000;
			estado <= state;
		end
		MemoryRead:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b0;
			aluControl = 3'b001;
			estado <= state;
		end
		WaitMemoryRead:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b0;
			aluControl = 3'b001;
			estado <= state;
		end
		PCWrite:
		begin
			memWriteOrRead = 1'b0;
			pcControl = 1'b1;
			aluControl = 3'b001;
			estado <= state;
		end
		endcase
	end
		
	
endmodule: unidadeControle