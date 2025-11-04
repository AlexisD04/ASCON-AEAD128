`timescale 1ns / 1ps

module substitution import ascon_pack::*; (

	input type_state S_i,
	output type_state S_o
);

	genvar i;

	generate
	for (i=0; i<64; i++) begin : g_label1

	sbox sbox_inst (
		.S_i({S_i[0][i],S_i[1][i],S_i[2][i],S_i[3][i],S_i[4][i]}),
		.S_o({S_o[0][i],S_o[1][i],S_o[2][i],S_o[3][i],S_o[4][i]})
);
	end : g_label1
	endgenerate
	endmodule : substitution
