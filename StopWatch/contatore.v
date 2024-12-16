module contatore (
    input clk_100Hz,    // Clock a 100 Hz generato dal clock divider
    input rst,          // Tasto di reset
    input enable,       // Tasto Start&Stop
    input direction,    // Switch per impostare la direzione del conteggio (0 = avanti, 1 = indietro)
    
    output reg [6:0] centisec,  // Contatore dei centesimi di secondo (0-99)
    output reg [5:0] sec,       // Contatore dei secondi (0-59)
    output reg [5:0] min,       // Contatore dei minuti (0-59)
    output reg [4:0] hr         // Contatore delle ore (0-23)
);
    reg running; // Stato del contatore (avviato/arrestato)
    reg enable_reg; // Registrazione dello stato precedente del tasto enable

    initial begin
        running = 0;
        enable_reg = 0;
    end

    always @(posedge clk_100Hz or posedge rst) begin
        if (rst) begin
            centisec <= 0;
            sec <= 0;
            min <= 0;
            hr <= 0;
            running <= 0; // Arresta il contatore al reset
        end else begin
            if (enable && !enable_reg) begin
                running <= ~running; // Cambia lo stato del contatore solo al fronte di salita di enable
            end

            enable_reg <= enable; // Aggiorna lo stato del tasto enable

            if (running) begin
                if (direction) begin
                    // Conteggio inverso
                    if (centisec == 0) begin
                        centisec <= 99;
                        if (sec == 0) begin
                            sec <= 59;
                            if (min == 0) begin
                                min <= 59;
                                if (hr == 0)
                                    hr <= 23;
                                else
                                    hr <= hr - 1;
                            end else
                                min <= min - 1;
                        end else
                            sec <= sec - 1;
                    end else
                        centisec <= centisec - 1;
                end else begin
                    // Conteggio avanti
                    if (centisec == 99) begin
                        centisec <= 0;
                        if (sec == 59) begin
                            sec <= 0;
                            if (min == 59) begin
                                min <= 0;
                                if (hr == 23)
                                    hr <= 0;
                                else
                                    hr <= hr + 1;
                            end else
                                min <= min + 1;
                        end else
                            sec <= sec + 1;
                    end else
                        centisec <= centisec + 1;
                end
            end
        end
    end
endmodule
