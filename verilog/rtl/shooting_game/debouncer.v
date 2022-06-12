// File debouncer.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
// vhd2vl settings:
//  * Verilog Module Declaration Style: 2001

// vhd2vl is Free (libre) Software:
//   Copyright (C) 2001 Vincenzo Liguori - Ocean Logic Pty Ltd
//     http://www.ocean-logic.com
//   Modifications Copyright (C) 2006 Mark Gonzales - PMC Sierra Inc
//   Modifications (C) 2010 Shankar Giri
//   Modifications Copyright (C) 2002-2017 Larry Doolittle
//     http://doolittle.icarus.com/~larry/vhd2vl/
//   Modifications (C) 2017 Rodrigo A. Melo
//
//   vhd2vl comes with ABSOLUTELY NO WARRANTY.  Always check the resulting
//   Verilog for correctness, ideally with a formal verification tool.
//
//   You are welcome to redistribute vhd2vl under certain conditions.
//   See the license (GPLv2) file included with the source for details.

// The result of translation follows.  Its copyright status should be
// considered unchanged from the original VHDL.

//--------------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------------
// no timescale needed

module debouncer(
  input wire input,
  input wire clock,
  output wire output
);

  wire sig1;
  wire sig2;
  wire sig3;
  wire sig4;

  dff ex0(
    .Q(sig1),
    .C(clock),
    .D(input)
  );

  dff ex1(
    .Q(sig2),
    .C(clock),
    .D(sig1)
  );

  dff ex2(
    .Q(sig3),
    .C(clock),
    .D(sig2)
  );

  dff ex3(
    .Q(sig4),
    .C(clock),
    .D(sig3)
  );

  assign output = sig1 & sig4 & sig3 & sig2;

endmodule
