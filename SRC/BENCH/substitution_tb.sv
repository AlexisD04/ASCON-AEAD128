`timescale 1ns / 1ps

module substitution_tb import ascon_pack::*; ();

	type_state Si_s,So_s;

substitution DUT (
	.S_i(Si_s),
	.S_o(So_s)
);

initial begin
Si_s[0] = 64'h00001000808c0001;
Si_s[1] = 64'h6cb10ad9ca912f80;
Si_s[2] = 64'h691aed630e8190ef;
Si_s[3] = 64'h0c4c36a20853217c;
Si_s[4] = 64'h46487b3e06d9d7a8;
end
endmodule : substitution_tb 
