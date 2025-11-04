`timescale 1ns/1ps

module ascon_top import ascon_pack::*; 
(
	input logic start_i,
	input logic data_valid_i,
	input logic resetb_i,
	input logic clock_i,
	input logic[127:0] data_i,
	input logic[127:0] key_i,
	input logic[127:0] nonce_i,

	output logic end_o,
	output logic cipher_valid_o,
	output logic[127:0] tag_o,
	output logic[127:0] cipher_o
);

	type_state state_init_s;
	logic enable_s;
	logic init_a_s;
	logic init_b_s;
	logic init_state_s;
	logic ena_xor_up_s;
	logic ena_xor_down_s;
	logic write_enable_s;
	logic xor_down_s;
	logic[191:0] data_xor_down_s;
	logic[3:0] round_s;
	logic[1:0] conf_xor_down_s;
	

	always_comb begin
		state_init_s = {64'h00001000808c0001, key_i[63:0], key_i[127:64], nonce_i[63:0], nonce_i[127:64]};
	end
	
	fsm fsm (
		.start_i(start_i),
		.data_valid_i(data_valid_i),
		.round_i(round_s),
		.clock_i(clock_i),
		.resetb_i(resetb_i),
		.end_o(end_o),
		.cipher_valid_o(cipher_valid_o),
		.init_state_o(init_state_s),
		.ena_xor_up_o(ena_xor_up_s),
		.ena_xor_down_o(ena_xor_down_s),
		.init_a(init_a_s),
		.init_b(init_b_s),
		.enable(enable_s),
		.conf_xor_down(conf_xor_down_s),
		.write_enable_o(write_enable_s)
	);

	counter_double_init counter_double_init(
		.clock_i(clock_i),
		.resetb_i(resetb_i),
		.ena_i(enable_s),
		.init_a_i(init_a_s),
		.init_b_i(init_b_s),
		.count_o(round_s)
	);

	permutation_xor permutation_xor(
		.init_state_i(init_state_s),
		.clock_i(clock_i),
		.ctrl_1_i(ena_xor_up_s),
		.ctrl_2_i(ena_xor_down_s),
		.data_1_i(data_i),
		.data_2_i(data_xor_down_s),
		.rst_i(), //Possiblement inutile
		.round_i(round_s),
		.S_i(state_init_s),
		.write_enable_i(write_enable_s),
		.cipher_o(cipher_o),
		.tag_o(tag_o)
	);

	always_comb begin : multiplex
		case(conf_xor_down_s)
			0: begin
				data_xor_down_s  = {key_i[63:0],key_i[127:64]};
			end

			1: begin
				data_xor_down_s  = {129'b1,63'b0};
			end

			2: begin
				data_xor_down_s = {key_i[63:0],key_i[127:64],64'b0};
			end
		endcase
	end
endmodule : ascon_top
