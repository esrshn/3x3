`timescale 1ns / 1ps

module tb_snn_image_detector();

    // Sinyal tanımları
    logic clk;
    logic rst;
    logic [7:0] pixels[0:8];

    logic spike_top;
    logic spike_bottom;
    logic spike_left;
    logic spike_right;
    logic spike_top_left;
    logic spike_top_right;
    logic spike_bottom_left;
    logic spike_bottom_right;

    // Ana tasarımı (DUT) bağlama
    snn_image_detector uut (
        .clk(clk),
        .rst(rst),
        .pixels(pixels),
        .spike_top(spike_top),
        .spike_bottom(spike_bottom),
        .spike_left(spike_left),
        .spike_right(spike_right),
        .spike_top_left(spike_top_left),
        .spike_top_right(spike_top_right),
        .spike_bottom_left(spike_bottom_left),
        .spike_bottom_right(spike_bottom_right)
    );

    // 10ns periyotlu Saat (Clock) Üreteci
    always #5 clk = ~clk;

    // Test Senaryosu
    initial begin
        // Başlangıç değerleri
        clk = 0;
        rst = 1;
        for (int i = 0; i < 9; i++) pixels[i] = 8'd0;

        // Reset uygula
        #20;
        rst = 0;
        #10;

        // -------------------------------------------------------------
        // Test 1: Üst kenar (Top Edge) piksellerini besle
        // -------------------------------------------------------------
        pixels[0] = 8'd50; pixels[1] = 8'd50; pixels[2] = 8'd50;
        pixels[3] = 8'd0;  pixels[4] = 8'd0;  pixels[5] = 8'd0;
        pixels[6] = 8'd0;  pixels[7] = 8'd0;  pixels[8] = 8'd0;
        
        #100; // Devrenin işlemesi için bekle

        $display("\n========================================");
        $display("TEST 1: UST KENAR GURTUSI (3x3 Matris)");
        $display("========================================");
        $display("[%3d] [%3d] [%3d]", pixels[0], pixels[1], pixels[2]);
        $display("[%3d] [%3d] [%3d]", pixels[3], pixels[4], pixels[5]);
        $display("[%3d] [%3d] [%3d]", pixels[6], pixels[7], pixels[8]);
        $display("SPIKE_TOP DURUMU: %b", spike_top);
        $display("========================================\n");

        // -------------------------------------------------------------
        // Test 2: Sol üst köşe (Top-Left Corner) testi
        // -------------------------------------------------------------
        pixels[0] = 8'd60; pixels[1] = 8'd30; pixels[2] = 8'd0;
        pixels[3] = 8'd30; pixels[4] = 8'd0;  pixels[5] = 8'd0;
        pixels[6] = 8'd0;  pixels[7] = 8'd0;  pixels[8] = 8'd0;
        
        #100; 

        $display("\n========================================");
        $display("TEST 2: SOL UST KOSE GORUNTUSI (3x3 Matris)");
        $display("========================================");
        $display("[%3d] [%3d] [%3d]", pixels[0], pixels[1], pixels[2]);
        $display("[%3d] [%3d] [%3d]", pixels[3], pixels[4], pixels[5]);
        $display("[%3d] [%3d] [%3d]", pixels[6], pixels[7], pixels[8]);
        $display("SPIKE_TOP_LEFT DURUMU: %b", spike_top_left);
        $display("========================================\n");

        $finish;
    end

endmodule