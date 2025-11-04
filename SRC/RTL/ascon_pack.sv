package ascon_pack;

	// 320-bit state as five 64-bit words
	typedef logic[0:4][63:0] type_state;

	// Round constants for constant addition
	logic [7:0]	 round_constant [0:11] = {8'hF0, 8'hE1, 8'hD2, 8'hC3, 8'hB4, 8'hA5, 8'h96, 8'h87, 8'h78, 8'h69, 8'h5A, 8'h4B};

	// Number of rounds for p^a and p^b
	logic[3:0]	a = 12;
	logic[3:0]	b = 8;

	// Substitution constants
	logic[4:0] 	sub_constant [0:31] = {5'h04,5'h0B,5'h1F,5'h14,5'h1A,5'h15,5'h09,5'h02,5'h1B,5'h05,5'h08,5'h12,5'h1D,5'h03,5'h06,5'h1C,5'h1E,5'h13,5'h07,5'h0E,5'h00,5'h0D,5'h11,5'h18,5'h10,5'h0C,5'h01,5'h19,5'h16,5'h0A,5'h0F,5'h17};

endpackage : ascon_pack
