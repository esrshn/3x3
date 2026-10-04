module snn_image_detector #(
    parameter THRESHOLD = 8'd100,
    parameter LEAKAGE   = 8'd5
)(
    input  logic       clk,
    input  logic       rst,
    input  logic [7:0] pixels[0:8],

    output logic       spike_top,
    output logic       spike_bottom,
    output logic       spike_left,
    output logic       spike_right,
    output logic       spike_top_left,
    output logic       spike_top_right,
    output logic       spike_bottom_left,
    output logic       spike_bottom_right
);

    logic [11:0] v_top, v_bottom, v_left, v_right;
    logic [11:0] v_top_left, v_top_right, v_bottom_left, v_bottom_right;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            v_top <= 0; spike_top <= 0;
            v_bottom <= 0; spike_bottom <= 0;
            v_left <= 0; spike_left <= 0;
            v_right <= 0; spike_right <= 0;
        end else begin
            if (v_top + (pixels[0] + pixels[1] + pixels[2]) >= THRESHOLD) begin
                spike_top <= 1; v_top <= 0;
            end else begin
                spike_top <= 0;
                v_top <= (v_top + (pixels[0] + pixels[1] + pixels[2]) > LEAKAGE) ? 
                         (v_top + (pixels[0] + pixels[1] + pixels[2]) - LEAKAGE) : 0;
            end

            if (v_bottom + (pixels[6] + pixels[7] + pixels[8]) >= THRESHOLD) begin
                spike_bottom <= 1; v_bottom <= 0;
            end else begin
                spike_bottom <= 0;
                v_bottom <= (v_bottom + (pixels[6] + pixels[7] + pixels[8]) > LEAKAGE) ? 
                            (v_bottom + (pixels[6] + pixels[7] + pixels[8]) - LEAKAGE) : 0;
            end

            if (v_left + (pixels[0] + pixels[3] + pixels[6]) >= THRESHOLD) begin
                spike_left <= 1; v_left <= 0;
            end else begin
                spike_left <= 0;
                v_left <= (v_left + (pixels[0] + pixels[3] + pixels[6]) > LEAKAGE) ? 
                          (v_left + (pixels[0] + pixels[3] + pixels[6]) - LEAKAGE) : 0;
            end

            if (v_right + (pixels[2] + pixels[5] + pixels[8]) >= THRESHOLD) begin
                spike_right <= 1; v_right <= 0;
            end else begin
                spike_right <= 0;
                v_right <= (v_right + (pixels[2] + pixels[5] + pixels[8]) > LEAKAGE) ? 
                           (v_right + (pixels[2] + pixels[5] + pixels[8]) - LEAKAGE) : 0;
            end
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            v_top_left <= 0; spike_top_left <= 0;
            v_top_right <= 0; spike_top_right <= 0;
            v_bottom_left <= 0; spike_bottom_left <= 0;
            v_bottom_right <= 0; spike_bottom_right <= 0;
        end else begin
            if (v_top_left + (pixels[0]*2 + pixels[1] + pixels[3]) >= THRESHOLD) begin
                spike_top_left <= 1; v_top_left <= 0;
            end else begin
                spike_top_left <= 0;
                v_top_left <= (v_top_left + (pixels[0]*2 + pixels[1] + pixels[3]) > LEAKAGE) ? 
                              (v_top_left + (pixels[0]*2 + pixels[1] + pixels[3]) - LEAKAGE) : 0;
            end

            if (v_top_right + (pixels[2]*2 + pixels[1] + pixels[5]) >= THRESHOLD) begin
                spike_top_right <= 1; v_top_right <= 0;
            end else begin
                spike_top_right <= 0;
                v_top_right <= (v_top_right + (pixels[2]*2 + pixels[1] + pixels[5]) > LEAKAGE) ? 
                               (v_top_right + (pixels[2]*2 + pixels[1] + pixels[5]) - LEAKAGE) : 0;
            end

            if (v_bottom_left + (pixels[6]*2 + pixels[3] + pixels[7]) >= THRESHOLD) begin
                spike_bottom_left <= 1; v_bottom_left <= 0;
            end else begin
                spike_bottom_left <= 0;
                v_bottom_left <= (v_bottom_left + (pixels[6]*2 + pixels[3] + pixels[7]) > LEAKAGE) ? 
                                 (v_bottom_left + (pixels[6]*2 + pixels[3] + pixels[7]) - LEAKAGE) : 0;
            end

            if (v_bottom_right + (pixels[8]*2 + pixels[5] + pixels[7]) >= THRESHOLD) begin
                spike_bottom_right <= 1; v_bottom_right <= 0;
            end else begin
                spike_bottom_right <= 0;
                v_bottom_right <= (v_bottom_right + (pixels[8]*2 + pixels[5] + pixels[7]) > LEAKAGE) ? 
                                  (v_bottom_right + (pixels[8]*2 + pixels[5] + pixels[7]) - LEAKAGE) : 0;
            end
        end
    end

endmodule