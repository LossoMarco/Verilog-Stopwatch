module display_mode (
    input clk,             // Clock di sistema a 100 Hz
    input key,             // Tasto di commutazione
    input parziale,        // Tasto di tempo parziale
    input [6:0] centisec,
    input [5:0] sec, min,
    input [4:0] hr,
    output reg [3:0] disp0, disp1, disp2, disp3, disp4, disp5 // Valori BCD da visualizzare
);
    reg mode; // Modalità di visualizzazione: 0 = cent, sec, min; 1 = sec, min, hr
    reg parziale_mode; // Stato del tempo parziale
    reg [31:0] parziale_counter; // Contatore per il tempo parziale
    reg [6:0] parziale_centisec;
    reg [5:0] parziale_sec, parziale_min;
    reg [4:0] parziale_hr;

    initial begin
        mode = 0;
        parziale_mode = 0;
        parziale_counter = 0;
    end

    // Gestione del contatore e della modalità del tempo parziale
    always @(posedge clk) begin
        if (parziale_mode) begin
            if (parziale_counter < 500) begin // 5 secondi a 100 Hz
                parziale_counter <= parziale_counter + 1;
            end else begin
                parziale_mode <= 0;
                parziale_counter <= 0;
            end
        end

        if (parziale && !parziale_mode) begin
            // Attiva il tempo parziale quando `parziale` è premuto
            parziale_mode <= 1;
            parziale_counter <= 0;
            // Memorizza i valori attuali del contatore
            parziale_centisec <= centisec;
            parziale_sec <= sec;
            parziale_min <= min;
            parziale_hr <= hr;
        end
    end

    // Logica per la commutazione di `mode`
    always @(negedge clk) begin
        if (key) begin
            mode <= ~mode; // Cambia modalità quando `key` è premuto
        end
    end

    always @(*) begin
        if (parziale_mode) begin
            // Visualizza i valori memorizzati (tempo parziale)
            if (mode == 0) begin
                disp0 = parziale_centisec % 10;
                disp1 = parziale_centisec / 10;
                disp2 = parziale_sec % 10;
                disp3 = parziale_sec / 10;
                disp4 = parziale_min % 10;
                disp5 = parziale_min / 10;
            end else begin
                disp0 = parziale_sec % 10;
                disp1 = parziale_sec / 10;
                disp2 = parziale_min % 10;
                disp3 = parziale_min / 10;
                disp4 = parziale_hr % 10;
                disp5 = parziale_hr / 10;
            end
        end else begin
            // Visualizza i valori attuali del contatore
            if (mode == 0) begin
                disp0 = centisec % 10;
                disp1 = centisec / 10;
                disp2 = sec % 10;
                disp3 = sec / 10;
                disp4 = min % 10;
                disp5 = min / 10;
            end else begin
                disp0 = sec % 10;
                disp1 = sec / 10;
                disp2 = min % 10;
                disp3 = min / 10;
                disp4 = hr % 10;
                disp5 = hr / 10;
            end
        end
    end
endmodule