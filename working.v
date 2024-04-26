//fixed to be implemented in hardware    

`timescale 1ps/1ps

module board(
    input clk,
    output move_made1, output move_made2, output move_made3, output move_made4, output move_made5, output move_made6, output move_made7, output move_made8, output move_made9,

    output [1:0] output1, output [1:0] output2, output [1:0] output3, output [1:0] output4, output [1:0] output5, output [1:0] output6, output [1:0] output7, output [1:0] output8, output [1:0] output9,
    input clk, 
    input button1, input button2, input button3, input button4, input button5, input button6, input button7, input button8, input button9
);
    reg player = 0;

 

    game_cell c1(clk, button1, player, output1, move_made1);
    game_cell c2(clk, button2, player, output2, move_made2);
    game_cell c3(clk, button3, player, output3, move_made3);
    game_cell c4(clk, button4, player, output4, move_made4);
    game_cell c5(clk, button5, player, output5, move_made5);
    game_cell c6(clk, button6, player, output6, move_made6);
    game_cell c7(clk, button7, player, output7, move_made7);
    game_cell c8(clk, button8, player, output8, move_made8);
    game_cell c9(clk, button9, player, output9, move_made9);

    wire move_made = move_made1 || move_made2 || move_made3 || move_made4 || move_made5 || move_made6 || move_made7 || move_made8 || move_made9;

    always @(posedge clk) begin
        
        if (move_made) begin
            player <= !player;
            
        end
        
    end

endmodule


module game_cell(input gclk, input button, input player, output [1:0]out_values, output out_write);
    reg[1:0] values = 2'b00;
    wire[1:0] input_data = {1'b1, player};
    wire write = !values[1] && button;
    always @(posedge gclk) begin
        if (write) begin
            values <= input_data;
        end
    end
	assign out_values = values;
    assign out_write = write;
    
endmodule




