`timescale 1ns/1ps;

module tt_um_yannickreiss_alu (input wire [7:0] ui_in,    // Dedicated inputs
                                     output wire [7:0] uo_out,  // Dedicated outputs
                                     input wire [7:0] uio_in,   // IOs: Input path
                                     output wire [7:0] uio_out, // IOs: Output path
                                     output wire [7:0] uio_oe,  // IOs: Enable path (active high: 0 = input, 1 = output
                                     input wire ena,
                                     input wire clk,
                                     input wire rst_n);

// One Froggy a day keeps the sadness away!
endmodule
