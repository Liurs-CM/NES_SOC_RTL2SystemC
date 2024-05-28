.PHONY: all  
  
all:  
	@start_time=$$(date +%s);
	@echo "Start time: $$(date)";
	sleep 1; # 模拟一个耗时任务  
	@end_time=$$(date +%s);
	duration=$(shell echo "( $(end_time) - $(start_time) )");
	@echo "End time: $$(date)";
	@echo "Execution duration: $(duration) seconds"
