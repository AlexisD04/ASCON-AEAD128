`timescale 1ns / 1ps

module permutation_xor_tb import ascon_pack::*; ();

	type_state S_i;
	logic[3:0] round_i;
	logic init_state_i, clock_i, rst_i,ctrl_1_i,ctrl_2_i;
	logic[191:0] data_2_i;
	logic[127:0] data_1_i;
	logic write_enable_i;
	logic[127:0] cipher_o;
	logic[127:0] tag_o;

	permutation_xor DUT (
		.S_i(S_i),
		.cipher_o(cipher_o),
		.tag_o(tag_o),
		.round_i(round_i),
		.init_state_i(init_state_i),
		.clock_i(clock_i),
		.rst_i(rst_i),
		.ctrl_1_i(ctrl_1_i),
		.ctrl_2_i(ctrl_2_i),
		.data_1_i(data_1_i),
		.data_2_i(data_2_i),
		.write_enable_i(write_enable_i)
	);

initial begin
clock_i = 1'b0;
forever #5 clock_i = ~clock_i;
end

initial begin

S_i[0] = 64'h00001000808C0001;
S_i[1] = 64'h6CB10AD9CA912F80;
S_i[2] = 64'h691AED630E81901F;
S_i[3] = 64'h0C4C36A20853217C;
S_i[4] = 64'h46487B3E06D9D7A8;

write_enable_i = 'b1;
init_state_i = 'b0;
round_i = 4'b0;
rst_i = 'b1;
ctrl_1_i = 'b0;
ctrl_2_i = 'b0;

#5;
init_state_i = 1'b1;

//Round 1
#10;
init_state_i = 1'b0;
round_i ++;

//Round 2
#10;
round_i ++;

//Round 3
#10;
round_i ++;

//Round 4
#10;
round_i ++;

//Round 5
#10;
round_i ++;

//Round 6
#10;
round_i ++;

//Round 7
#10;
round_i ++;

//Round 8
#10;
round_i ++;

//Round 9
#10;
round_i ++;

//Round 10
#10;
round_i ++;

//Round 11
#10;
round_i ++;

#2
ctrl_2_i = 1'b1;
data_2_i = {64'h0,S_i[1],S_i[2]};

#8;
ctrl_2_i = 1'b0;
round_i = 'h04;


end
endmodule : permutation_xor_tb
