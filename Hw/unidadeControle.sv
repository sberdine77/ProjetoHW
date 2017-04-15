module unidadeControle
(	input logic clk, reset, 
	output logic memRead, memWrite, pcControl, 
	output logic [2:0] aluControl);

	
	enum logic [1:0] {Reset ,MemoryRead, WaitMemoryRead, PCWrite} state;
	
	initial state <= Reset;
	
	always_ff@(posedge clk, negedge reset)
	begin
		
		case(state)
		Reset: state <= MemoryRead;
		MemoryRead: state <= WaitMemoryRead;
		WaitMemoryRead: state <= PCWrite;
		default: state <= Reset;
		endcase
	end
	
	always_comb
	begin
		case(state)
		Reset:
		begin
			memRead = 1'b0;
			memWrite = 1'b0;
			pcControl = 1'b0;
			aluControl = 3'b000;
		end
		MemoryRead:
		begin
			memRead = 1'b1;
			memWrite = 1'b0;
			pcControl = 1'b0;
			aluControl = 3'b001;
		end
		WaitMemoryRead:
		begin
			memRead = 1'b1;
			memWrite = 1'b0;
			pcControl = 1'b0;
			aluControl = 3'b001;
		end
		PCWrite:
		begin
			memRead = 1'b0;
			memWrite = 1'b0;
			pcControl = 1'b1;
			aluControl = 3'b001;
		end
		endcase
	end
		
	
endmodule: unidadeControle