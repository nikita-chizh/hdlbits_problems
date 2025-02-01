  module top_module(
    input clk, input areset, input bump_left, input bump_right,
    input ground, output walk_left,
    output walk_right, output aaah ); 
    
    enum bit {LEFT, RIGHT} DIRECTION;
    enum bit {WALKS, FALLS} FALLING;

    reg curr_dir, next_dir;
    reg curr_fal, next_fal;

    always @(*) begin : state_trans
        if (ground == 0)
        begin
            next_fal = FALLS;
            next_dir = curr_dir;
        end
        else if (ground == 1)
        begin
            next_fal = WALKS;
            if (curr_fal == WALKS)
            begin
                if (walk_left && bump_left)
                    next_dir = RIGHT;
                else if (walk_right && bump_right)
                    next_dir = LEFT;
                else
                    next_dir = curr_dir;
            end
            else if (curr_fal == FALLS)
            begin
                next_dir = curr_dir;
            end
        end
    end

    always @(posedge clk, posedge areset) begin
        if (areset)
        begin
            curr_dir <= LEFT;
            curr_fal <= WALKS;
        end
        else
        begin
            curr_dir <= next_dir;
            curr_fal <= next_fal;
        end
    end


    always_comb begin : output_logic
        if (curr_fal == FALLS)
        begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
        end
        else
        begin
            walk_left = curr_dir == LEFT ? 1 : 0;
            walk_right = curr_dir == RIGHT ? 1 : 0;
            aaah = 0;
        end
    end
endmodule
