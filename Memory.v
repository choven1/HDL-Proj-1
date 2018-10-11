
module Memory(Color,SendColor,Go,LBtn,RBtn,clk,reset);
	output reg [4:0] Color;
	output SendColor;
	input	Go, clk, reset;

	reg [4:0]	S, nS;

	always @(reset,S,nS)
	begin
		if (reset) begin
			
		end
	end


endmodule

/*Go signal selects currently hovered color
	Initial state		: flash all colors X times
	First state			: output Pattern
	Second state		: Move to [Score state] if confirm count==pattern length, else wait for input
		Left state		: If [left button]: move left 1 LED, return to [Second state]
		Right state		: IF [Right button]: move right 1 LED, return to [Second state]
		Confirm state	: IF [Go] Compare hovered color to current color in pattern, return to [Second state]
	Score state			: Compare confirmed colors to pattern, If match: increment [Score], else reset game, Move to [Win state]
	Win state				: If pattern number==(max)&&[Score]==(max), display winner, else move to [First state]