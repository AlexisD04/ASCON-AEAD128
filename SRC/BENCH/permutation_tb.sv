`timescale 1ns / 1ps

module permutation_tb import ascon_pack::*; ();

	type_state S_i;
	logic[3:0] round_i;
	logic init_state_i, clock_i, rst_i;

	permutation DUT (
		.S_i(S_i),
		.round_i(round_i),
		.init_state_i(init_state_i),
		.clock_i(clock_i),
		.rst_i(rst_i)
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

init_state_i = 'b0;
round_i = 4'b0;
rst_i = 'b1;

#5;
init_state_i = 1'b1;

#10;
init_state_i = 1'b0;
round_i ++;

#10;
round_i ++;

#10;
round_i ++;

#10;
round_i ++;

#10;
round_i ++;

#10;
round_i ++;

#10;
round_i ++;

#10;
round_i ++;

#10;
round_i ++;

#10;
round_i ++;

#10;
round_i ++;

end
endmodule : permutation_tb
