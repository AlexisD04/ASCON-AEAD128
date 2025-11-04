`timescale 1ns / 1ps 

module permutation import ascon_pack::*; (
	input logic init_state_i,
	input logic clock_i,
	input logic rst_i,
	input logic[3:0] round_i,
	input type_state S_i
);

	type_state state_mux_s,state_reg_s,S1_s,S2_s,S3_s;
	
	assign state_mux_s = (init_state_i) ? S_i : state_reg_s;

	constant_add constant_add_p(
		.round_i(round_i),
		.S_i(state_mux_s),
		.S_o(S1_s)
	);

	substitution substitution_p(
		.S_i(S1_s),
		.S_o(S2_s)
	);

	diffusion diffusion_p (
		.S_i(S2_s),
		.S_o(S3_s)
	);

	//Register
	always_ff @(posedge clock_i, negedge rst_i) begin
		if (rst_i == 1'b0) begin
			state_reg_s <= {64'h0, 64'h0, 64'h0, 64'h0, 64'h0};
		end

		else begin
			state_reg_s <= S3_s;
		end
	end

endmodule : permutation	
