`timescale 1ns/1ps

module fsm import ascon_pack::*;
(
	input logic start_i,
	input logic data_valid_i,
	input logic[3:0] round_i,
	input logic clock_i,
	input logic resetb_i,
	output logic end_o,
	output logic cipher_valid_o,
	output logic init_state_o,
	output logic ena_xor_up_o,
	output logic ena_xor_down_o,
	output logic init_a,
	output logic init_b,
	output logic enable,
	output logic[1:0] conf_xor_down,
	output logic write_enable_o
);

	typedef enum {
		idle,init_counter,init,init_permutation12,init_xor_down,init_wait,init_xor_up,data_permutation8,data_xor_down,data_wait,data_xor_up,text_permutation8,text_wait_0,text_xor_up,text_permutation8_2,text_xor_down,text_wait,text_xor_up_2,end_permutation12,end_xor_down,end_final
	} state_t;

	state_t current_state,next_state;

	always_ff @(posedge clock_i, negedge resetb_i) begin : reset
		if (resetb_i == 'b0) current_state <= idle;
		else current_state <= next_state;

	end : reset

	always_comb begin : switch_state
		case(current_state)
			idle: begin
				if (start_i == 1'b1) next_state = init_counter;
				else next_state = idle;
			end

			init_counter: begin
				next_state = init;
			end

			init: begin
				next_state = init_permutation12;
			end

			init_permutation12: begin
				if (round_i == 4'b1010) next_state = init_xor_down;
				else next_state = init_permutation12;
			end

			init_xor_down: begin
				if (data_valid_i == 1) next_state = init_xor_up;
				else next_state = init_wait;
			end

			init_wait: begin
				if (data_valid_i == 1) next_state = init_xor_up;
				else next_state = init_wait;
			end

			init_xor_up: begin
				next_state = data_permutation8;
			end

			data_permutation8: begin
				if (round_i == 4'b1010) next_state = data_xor_down;
				else next_state = data_permutation8;
			end

			data_xor_down: begin
				if (data_valid_i == 1) next_state = data_xor_up;
				else next_state = data_wait;
			end

			data_wait: begin
				if (data_valid_i == 1) next_state = data_xor_up;
				else next_state = data_wait;
			end

			data_xor_up: begin
				next_state = text_permutation8;
			end

			text_permutation8: begin
				if (round_i == 4'b1010) next_state = text_wait_0;
				else next_state = text_permutation8;
			end
			
			text_wait_0: begin
				if (data_valid_i == 1) next_state = text_xor_up;
				else next_state = text_wait_0;
			end

			text_xor_up: begin
				next_state = text_permutation8_2;
			end

			text_permutation8_2: begin
				if (round_i == 4'b1010) next_state = text_xor_down;
				else next_state = text_permutation8_2;
			end

			text_xor_down: begin
				if (data_valid_i == 1) next_state = text_xor_up_2;
				else next_state = text_wait;
			end

			text_wait: begin
				if (data_valid_i == 1) next_state = text_xor_up_2;
				else next_state = text_wait;
			end

			text_xor_up_2: begin
				next_state = end_permutation12;
			end

			end_permutation12: begin
				if (round_i == 4'b1010) next_state = end_xor_down;
				else next_state = end_permutation12;
			end

			end_xor_down: begin
				next_state = end_final;
			end

			end_final: begin
				next_state = end_final;
			end

		endcase

	end : switch_state

	always_comb begin : switch_signal
		case(current_state)
			idle: begin
				end_o = 'b0;
				cipher_valid_o = 'b0;
				init_state_o = 'b0;
				ena_xor_up_o = 'b0;
				ena_xor_down_o = 'b0;
				init_a = 'b0;
				init_b = 'b0;
				enable = 'b0;
				conf_xor_down = 'b0;
				write_enable_o = 'b0;
			end

			init_counter: begin
				init_a = 'b1;
				enable = 'b1;
			end

			init: begin
				init_a = 'b0;
				init_state_o = 'b1;
				write_enable_o = 'b1;
			end

			init_permutation12: begin
				init_state_o = 'b0;
			end

			init_xor_down: begin
				ena_xor_down_o = 'b1;
				conf_xor_down = 'b0;
				init_b = 'b1;
			end

			init_wait: begin
				enable = 'b0;
				write_enable_o = 'b0;
			end

			init_xor_up: begin
				ena_xor_up_o = 'b1;
				ena_xor_down_o = 'b0;
				init_b = 'b0;
				enable = 'b1;
				write_enable_o = 'b1;
			end

			data_permutation8: begin
				ena_xor_up_o ='b0;
			end

			data_xor_down: begin
				ena_xor_down_o = 'b1;
				conf_xor_down = 'b1;
				init_b = 'b1;
			end

			data_wait: begin
				enable = 'b0;
				write_enable_o ='b0;
			end

			data_xor_up: begin
				ena_xor_up_o = 'b1;
				ena_xor_down_o = 'b0;
				init_b = 'b0;
				enable = 'b1;
				write_enable_o = 'b1;
				cipher_valid_o = 'b1;
			end

			text_permutation8: begin
				ena_xor_up_o = 'b0;
				cipher_valid_o = 'b0; 
			end

			text_wait_0: begin
				//write_enable_o = 'b0;
				//enable = 'b0;
				init_b = 'b1;
			end

			text_xor_up: begin
				ena_xor_up_o = 'b1;
				init_b = 'b0;
				//enable = 'b1;
				//write_enable_o = 'b1;
				cipher_valid_o = 'b1;
			end

			text_permutation8_2: begin
				ena_xor_up_o = 'b0;
				init_b = 0;
				write_enable_o = 'b1;
				cipher_valid_o = 'b0;
			end

			text_xor_down: begin
				init_a = 'b1;
				ena_xor_down_o = 'b1;
				conf_xor_down = 'b10;
			end

			text_wait: begin
				enable = 'b0;
				write_enable_o = 'b0;
			end

			text_xor_up_2: begin
				write_enable_o = 'b1;
				init_a = 'b0;
				ena_xor_up_o = 'b1;
				ena_xor_down_o = 'b0;
				enable = 'b1;
				cipher_valid_o = 'b1;
			end

			end_permutation12: begin
				ena_xor_up_o = 'b0;
				init_a = 'b0;
				enable = 'b1;
				cipher_valid_o = 'b0;
			end

			end_xor_down: begin
				ena_xor_down_o = 'b1;
				conf_xor_down = 'b0;
			end

			end_final: begin
				write_enable_o = 'b0;
				end_o = 'b1;
				enable = 'b0;
				ena_xor_down_o = 'b0;
			end

		endcase

	end : switch_signal
	
endmodule : fsm
