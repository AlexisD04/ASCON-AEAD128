`timescale 1ns / 1ps

module sbox import ascon_pack::*;(
	input logic[4:0] S_i,
	output logic[4:0] S_o
);

	logic[4:0] vecteur;
	logic[4:0] result;

	always_comb begin
		
		vecteur[0] = S_i[0];
		vecteur[1] = S_i[1];
		vecteur[2] = S_i[2];
		vecteur[3] = S_i[3];
		vecteur[4] = S_i[4];

		result = sub_constant[vecteur];

		S_o[0] = result[0];
		S_o[1] = result[1];
		S_o[2] = result[2];
		S_o[3] = result[3];
		S_o[4] = result[4];

	end	

endmodule : sbox
