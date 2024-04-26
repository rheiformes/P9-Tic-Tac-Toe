`timescale 1ps/1ps

module game_cell(input clk, input button, input player, output [1:0]out_values, output out_write);
    reg[1:0] values = 2'b00;
    wire[1:0] input_data = {1'b1, player};
    wire write = !values[1] && button;
    always @(posedge clk) begin
        if (write) begin
            values <= input_data;
        end
    end

    assign out_values = values;
    assign out_write = write;
endmodule

module gameDisplay(input clk, input [1:0]cell1, input [1:0]cell2, input [1:0]cell3, input [1:0]cell4, input [1:0]cell5, input [1:0]cell6, input [1:0]cell7, input [1:0]cell8, input [1:0]cell9);
    always @(posedge clk) begin
        $display(" %d | %d | %d \n", cell1, cell2, cell3);
        $display(" %d | %d | %d \n", cell4, cell5, cell6);
        $display(" %d | %d | %d \n", cell7, cell8, cell9);
        $display("-----------\n");
    end
endmodule

module clock(output clk);
    reg theClock = 1;
    assign clk = theClock;

    always begin
        #500;
        theClock = !theClock;
    end
endmodule

module main();
    initial begin
        $dumpfile("game.vcd");
        $dumpvars(0,main);
    end
    reg player = 0;
    wire clk;
    reg[16:0] counter = 0;
    clock c0(clk);
    wire move_made = move_made1 || move_made2 || move_made3 || move_made4 || move_made5 || move_made6 || move_made7 || move_made8 || move_made9;
    
    
    always @(posedge clk) begin
        counter <= counter + 1;
        if (counter == 10) begin
            $finish;
        end
        if (move_made) begin
            player <= !player;
            
        end
        $display("Player %d's turn", player);
        action1 <= action2;
        action2 <= action3;
        action3 <= action4;
        action4 <= action5;
        action5 <= action6;
    end
    reg[8:0] action1 = 9'b001000000;
    reg[8:0] action2 = 9'b000001000;
    reg[8:0] action3 = 9'b000100000;
    reg[8:0] action4 = 9'b000000010;
    reg[8:0] action5 = 9'b100000000;
    reg[8:0] action6 = 9'b010000000;

    wire move_made1;
    wire move_made2;
    wire move_made3;
    wire move_made4;
    wire move_made5;
    wire move_made6;
    wire move_made7;
    wire move_made8;
    wire move_made9;

    wire[1:0] output1;
    wire[1:0] output2;
    wire[1:0] output3;
    wire[1:0] output4;
    wire[1:0] output5;
    wire[1:0] output6;
    wire[1:0] output7;
    wire[1:0] output8;
    wire[1:0] output9;
    gameDisplay disp(clk, output1, output2, output3, output4, output5, output6, output7, output8, output9);

    wire button1 = action1[0];
    wire button2 = action1[1];
    wire button3 = action1[2];
    wire button4 = action1[3];
    wire button5 = action1[4];
    wire button6 = action1[5];
    wire button7 = action1[6];
    wire button8 = action1[7];
    wire button9 = action1[8];

    game_cell c1(clk, button1, player, output1, move_made1);
    game_cell c2(clk, button2, player, output2, move_made2);
    game_cell c3(clk, button3, player, output3, move_made3);
    game_cell c4(clk, button4, player, output4, move_made4);
    game_cell c5(clk, button5, player, output5, move_made5);
    game_cell c6(clk, button6, player, output6, move_made6);
    game_cell c7(clk, button7, player, output7, move_made7);
    game_cell c8(clk, button8, player, output8, move_made8);
    game_cell c9(clk, button9, player, output9, move_made9);

endmodule
