`timescale 1ns / 1ps

module diffusion_tb import ascon_pack::*; ();

	type_state Si_s;
	type_state So_s;

	diffusion DUT (
		.S_i(Si_s),
		.S_o(So_s)
);

initial begin
Si_s[0] = 64'h25f7c341c45f9912;
Si_s[1] = 64'h23b794c540876856;
Si_s[2] = 64'hb85451593d679610;
Si_s[3] = 64'h4fafba264a9e49ba;
Si_s[4] = 64'h62b54d5d460aded4;
end
endmodule : diffusion_tb
