//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module Cronometro(

    //////////// CLOCK //////////
    input                       CLOCK2_50,
    input                       CLOCK3_50,
    input                       CLOCK4_50,
    input                       CLOCK_50,

    //////////// SEG7 //////////
    output           [6:0]      HEX0,
    output           [6:0]      HEX1,
    output           [6:0]      HEX2,
    output           [6:0]      HEX3,
    output           [6:0]      HEX4,
    output           [6:0]      HEX5,

    //////////// KEY //////////
    input            [3:0]      KEY,

    //////////// LED //////////
    output           [9:0]      LEDR,

    //////////// SW //////////
    input            [9:0]      SW,

    //////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
    inout           [35:0]      GPIO1GPIO
);

//=======================================================
//  REG/WIRE declarations
//=======================================================
wire clk_100Hz;
wire rst = ~KEY[0]; // Reset attivo alto
wire enable = ~KEY[1]; // Start/Stop alttivo alto
wire parziale = ~KEY[2];  // Tasto per visualizzazione tempo parziale
wire disp_mode = ~KEY[3]; // Tasto per la commutazione delle modalità, invertito
wire direzione_conteggio = SW[0]; // Switch per impostare la direzione del conteggio (0 = avanti, 1 = indietro)
wire [6:0] centisec;
wire [5:0] sec, min;
wire [4:0] hr;
wire [3:0] disp0, disp1, disp2, disp3, disp4, disp5;

//=======================================================
//  Structural coding
//=======================================================

// Istanza del modulo ClockDivider per generare clk_100Hz da CLOCK_50
clock_divider clock_divider (
    .clk_in(CLOCK_50),
    .clk_100Hz(clk_100Hz)
);

// Istanza del modulo Counter
contatore contatore (
    .clk_100Hz(clk_100Hz),
    .rst(rst),
	 .enable(enable),
	 .direction(direzione_conteggio),
    .centisec(centisec),
    .sec(sec),
    .min(min),
    .hr(hr)
);

// Istanza del modulo DisplaySwitcher
display_mode display_mode (
    .clk(clk_100Hz),
    .key(disp_mode),
	 .parziale(parziale),
    .centisec(centisec),
    .sec(sec),
    .min(min),
    .hr(hr),
    .disp0(disp0),
    .disp1(disp1),
    .disp2(disp2),
    .disp3(disp3),
    .disp4(disp4),
    .disp5(disp5)
);

// Istanza del modulo DisplayDriver per la visualizzazione sui display a 7 segmenti
display_driver display_driver (
    .clk(clk_100Hz),
    .disp0(disp0),
    .disp1(disp1),
    .disp2(disp2),
    .disp3(disp3),
    .disp4(disp4),
    .disp5(disp5),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .HEX3(HEX3),
    .HEX4(HEX4),
    .HEX5(HEX5)
);

endmodule