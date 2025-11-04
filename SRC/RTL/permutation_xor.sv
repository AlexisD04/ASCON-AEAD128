`timescale 1ns / 1ps 

module permutation_xor import ascon_pack::*; (
	input logic init_state_i,
	input logic clock_i,
	input logic ctrl_1_i,
	input logic ctrl_2_i,
	input logic[127:0] data_1_i,
	input logic[191:0] data_2_i,
	input logic rst_i,
	input logic[3:0] round_i,
	input type_state S_i,
	input write_enable_i,
	output logic[127:0] cipher_o,
	output logic[127:0] tag_o
);

	type_state signal_1_s,signal_2_s,signal_3_s,state_reg_s,signal_addition_s,signal_substitution_s,signal_diffusion_s;
	
	assign signal_1_s  = (init_state_i) ? S_i : state_reg_s;

	xor_up xor_up_p(
		.data_xor_up_i(data_1_i),
		.ena_xor_up_i(ctrl_1_i),
		.state_i(signal_1_s),
		.state_o(signal_2_s)
	);

	constant_add constant_add_p(
		.round_i(round_i),
		.S_i(signal_2_s),
		.S_o(signal_addition_s)
	);

	substitution substitution_p(
		.S_i(signal_addition_s),
		.S_o(signal_substitution_s)
	);

	diffusion diffusion_p (
		.S_i(signal_substitution_s),
		.S_o(signal_diffusion_s)
	);

	xor_down xor_down_p(
                .data_xor_down_i(data_2_i),
                .ena_xor_down_i(ctrl_2_i),
                .state_i(signal_diffusion_s),
                .state_o(signal_3_s)
        );

	//Register
	always_ff @(posedge clock_i, negedge rst_i) begin
		if (write_enable_i == 1'b1) begin
			state_reg_s <= signal_3_s;
		end

		if (rst_i == 1'b0) begin
			state_reg_s <= {64'h0, 64'h0, 64'h0, 64'h0, 64'h0};
		end

	end

	assign tag_o = {state_reg_s[4],state_reg_s[3]};
	assign cipher_o = {state_reg_s[2],state_reg_s[1],state_reg_s[0]};

endmodule : permutation_xor	
