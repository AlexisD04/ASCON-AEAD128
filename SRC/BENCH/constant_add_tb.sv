`timescale 1ns / 1ps

module constant_add_tb import ascon_pack::*; ();

	type_state Si_s;
	type_state So_s;
	logic[3:0] round_s;

	constant_add DUT (
		.S_i(Si_s),
		.S_o(So_s),
		.round_i(round_s)
	);

initial begin
	Si_s[0] = 64'h00001000808C0001;
	Si_s[1] = 64'h6CB10AD9CA912F80;
	Si_s[2] = 64'h691AED630E81901F;
	Si_s[3] = 64'h0C4C36A20853217C;
	Si_s[4] = 64'h46487B3E06D9D7A8;
	round_s = 4'b0;	
end
endmodule : constant_add_tb
