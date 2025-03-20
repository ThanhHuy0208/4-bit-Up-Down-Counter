module counter_4b(
	input logic clk_i,
	input logic rst_ni,
	input logic sel_i,
	output logic [3:0] out_o
	);
	
	logic [3:0] add_d, sub_d, out_d;
	
	adder_4b A0(out_d, 4'b1, add_d);
	subtractor_4b S0(out_d, 4'b1, sub_d);

	always_ff @(posedge clk_i or negedge rst_ni) begin
		if (!rst_ni) out_d <= 4'b0;
		else begin
			if (sel_i) out_d <= add_d;
			else if (!sel_i) out_d <= sub_d;
			else out_d <= out_o;
		end
	end
	
	assign out_o = out_d;
	
endmodule
