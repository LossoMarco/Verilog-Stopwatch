module clock_divider (
    input clk_in,       // Clock a 50 MHz
    output reg clk_100Hz  // Clock a 1 Hz
);
    reg [18:0] count;

    initial begin
        clk_100Hz = 0;    // Inizializza clk_1Hz
        count = 0;      // Inizializza count
    end

    always @(posedge clk_in) begin
        if (count == 250000) begin  //deve essere a 250.000
            count <= 0;
            clk_100Hz <= ~clk_100Hz;  // Switcha il clock di uscita
        end else begin
            count <= count + 1;
        end
    end
endmodule
