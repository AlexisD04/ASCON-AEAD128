`timescale 1ns / 1ps

module diffusion import ascon_pack::*; (
	input type_state S_i,
	output type_state S_o
);

	assign S_o[0] = S_i[0] ^ {S_i[0][18:0],S_i[0][63:19]} ^ {S_i[0][27:0],S_i[0][63:28]};
	assign S_o[1] = S_i[1] ^ {S_i[1][60:0],S_i[1][63:61]} ^ {S_i[1][38:0],S_i[1][63:39]};
	assign S_o[2] = S_i[2] ^ {S_i[2][0],S_i[2][63:1]} ^ {S_i[2][5:0],S_i[2][63:6]};
 	assign S_o[3] = S_i[3] ^ {S_i[3][9:0],S_i[3][63:10]} ^ {S_i[3][16:0],S_i[3][63:17]};
 	assign S_o[4] = S_i[4] ^ {S_i[4][6:0],S_i[4][63:7]} ^ {S_i[4][40:0],S_i[4][63:41]};
endmodule : diffusion
