module counter_tb();

	logic clk_i;
	logic rst_ni;
	logic sel_i;
	logic [3:0] out_o;
	
	synth_wrapper counter_4b(
		.clk(clk_i),
		.rst_n(rst_ni),
		.sel(sel_i),
		.out(out_o)
		);
		
	initial begin
		#0;
		clk_i = 1'b0;
		forever #5 clk_i = ~clk_i;
	end
	
	initial begin
		run_test();
	end
	
	initial begin
		$shm_open("tb.shm");
		$shm_probe("AS");
	end
	
	task run_test();
		#0;
		rst_ni = 1'b0;
		#20;
		rst_ni = 1'b1;
		repeat (100) @(posedge clk_i)
			sel_i = $urandom() % 2;
			//sel_i = 1'b1;
		
		#100;
		$finish;
	endtask
	
	task cnt_rst_test();
		#0;
		rst_ni = 1'b0;
		#20;
		rst_ni = 1'b1;
		sel_i = 1'b1;
		#100;
		$finish;
	endtask
	
	task cnt_up_test();
		#0;
		rst_ni = 1'b0;
		#20;
		rst_ni = 1'b1;
		sel_i = 1'b1;
		#100;
		$finish;
	endtask
	
	task cnt_down_test();
		#0;
		rst_ni = 1'b0;
		#20;
		rst_ni = 1'b1;
		sel_i = 1'b0;
		#100;
		$finish;
	endtask
	
	bit flag_check = 1'b0;
	
	task cnt_max_test();
		#0;
		rst_ni = 1'b0;
		#20;
		rst_ni = 1'b1;
		sel_i = 1'b1;
		repeat(100) @(posedge clk_i) begin
			#1;
			if (out_o == 4'b1111) flag_check = 1'b1;
			else if ((out_o == 4'b0000) & (!flag_check)) begin
						$display("Failed");
						$finish;
					end
			else flag_check = 1'b0;
		end
		#100;
		$finish;
	endtask
	
	
	task cnt_min_test();
		#0;
		rst_ni = 1'b0;
		//flag_check = 1'b0;
		#20;
		rst_ni = 1'b1;
		sel_i = 1'b0;
		repeat(100) @(posedge clk_i) begin
			#1;
			if (out_o == 4'b0000) flag_check = 1'b1;
			else if ((out_o == 4'b1111) & (!flag_check)) begin
						$display("Failed");
						$finish;
					end
			else flag_check = 1'b0;
		end
		#100;
		$finish;
	endtask
	
endmodule
