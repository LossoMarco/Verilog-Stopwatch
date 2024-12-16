module display_driver (
    input clk,
    input [3:0] disp0, disp1, disp2, disp3, disp4, disp5,
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

    // Istanza dei moduli SEG7_LUT per la visualizzazione sui display a 7 segmenti
    SEG7_LUT seg7_0 (.iDIG(disp0), .clk(clk), .enable(1'b1), .oSEG(HEX0));
    SEG7_LUT seg7_1 (.iDIG(disp1), .clk(clk), .enable(1'b1), .oSEG(HEX1));
    SEG7_LUT seg7_2 (.iDIG(disp2), .clk(clk), .enable(1'b1), .oSEG(HEX2));
    SEG7_LUT seg7_3 (.iDIG(disp3), .clk(clk), .enable(1'b1), .oSEG(HEX3));
    SEG7_LUT seg7_4 (.iDIG(disp4), .clk(clk), .enable(1'b1), .oSEG(HEX4));
    SEG7_LUT seg7_5 (.iDIG(disp5), .clk(clk), .enable(1'b1), .oSEG(HEX5));

endmodule