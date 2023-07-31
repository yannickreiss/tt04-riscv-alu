`timescale 1ns/1ps;

module tt_um_yannickreiss_alu (input wire [7:0] ui_in,    // Dedicated inputs
                                     output wire [7:0] uo_out,  // Dedicated outputs
                                     input wire [7:0] uio_in,   // IOs: Input path
                                     output wire [7:0] uio_out, // IOs: Output path
                                     output wire [7:0] uio_oe,  // IOs: Enable path (active high: 0 = input, 1 = output
                                     input wire ena,
                                     input wire clk,
                                     input wire rst_n);

        // sequence control
        reg [3:0] crtl;

        // ALU inputs
        reg [7:0] alu_op;
        reg [31:0] input1;
        reg [31:0] input2;

        // ALU output
        reg [31:0] result;
        reg [7:0] rout;

        assign uo_out = rout;

        always @(*) begin
                case (alu_op)
                        8'b00000000 : result = input1 + input2;
                        8'b00000001 : result = input1 - input2;
                        8'b00000010 : result = input1 <<< input2;
                        8'b00000011 : result = (input1 == input2); // TODO:
                        8'b00000100 : result = (input1 == input2); // TODO: Change to signed/unsigned
                        8'b00000101 : result = input1 ^ input2;
                        8'b00000110 : result = input1 >>> input2;
                        8'b00000111 : result = input1 >> input2; // TODO: Check if ror = sra
                        8'b00001000 : result = input1 | input2;
                        8'b00001001 : result = input1 & input2;
                        default: 
                                result = input1 + input2;
                endcase
        end

        always @(negedge rst_n) begin
                alu_op = 8'b0;
                input1 = 32'b0;
                input2 = 32'b0;
                result = 32'b0;
                crtl = 4'b0;
        end

        always @(posedge clk) begin
                case (crtl)
                        4'b0000: alu_op = ui_in;
                        4'b0001: input1 [31:24] = ui_in;
                        4'b0010: input1 [23:16] = ui_in;
                        4'b0011: input1 [15:8] = ui_in;
                        4'b0100: input1 [7:0] = ui_in;
                        4'b0101: input2 [31:24] = ui_in;
                        4'b0110: input2 [23:16] = ui_in;
                        4'b0111: input2 [15:8] = ui_in;
                        4'b1000: input2 [7:0] = ui_in;
                        4'b1001: rout = result[31:24];
                        4'b1010: rout = result[23:16];
                        4'b1011: rout = result[15:8];
                        4'b1100: rout = result[7:0];
                        default: crtl = 4'b0000;
                endcase
                
                if (alu_op >= 4'b1100) begin
                        crtl = 4'b0000;
                end else crtl = crtl + 1;
        end

// One Froggy a day keeps the sadness away!
endmodule
