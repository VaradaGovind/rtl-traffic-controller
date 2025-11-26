`timescale 1ns / 1ps

module Controller_tb;

    reg clk;
    reg rst;
    reg Sa, Sb;
    reg emergency_A, emergency_B;
    wire Ra, Rb, Ya, Yb, Ga, Gb;


    Controller uut (
        .clk(clk),
        .rst(rst),
        .Sa(Sa),
        .Sb(Sb),
        .emergency_A(emergency_A),
        .emergency_B(emergency_B),
        .Ra(Ra),
        .Rb(Rb),
        .Ya(Ya),
        .Yb(Yb),
        .Ga(Ga),
        .Gb(Gb)
    );

    always #5 clk = ~clk;

    initial begin
    
        clk = 0;
        rst = 1;
        Sa = 0; Sb = 0;
        emergency_A = 0; emergency_B = 0;

        #20;
        rst = 0;

        #50;  Sb = 1;    
        #50;  Sb = 0;    

        #60;  emergency_A = 1;
        #40;  emergency_A = 0; 

        #70;  emergency_B = 1;
        #40;  emergency_B = 0;

        #60;  Sa = 1; Sb = 1;
        #40;  Sa = 0; Sb = 0;

        #100;
        $finish;
    end

endmodule
