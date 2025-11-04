`timescale 1ns / 1ps

module constant_add import ascon_pack::*; 
	(
	input type_state S_i,
	input logic[3:0] round_i,
	output type_state S_o
	);

	assign S_o[0] = S_i[0];
	assign S_o[1] = S_i[1];
	assign S_o[2][63:8] = S_i[2][63:8];
	assign S_o[2][7:0] = S_i[2][7:0]^round_constant[round_i];
	assign S_o[3] = S_i[3];
	assign S_o[4] = S_i[4];

endmodule : constant_add
