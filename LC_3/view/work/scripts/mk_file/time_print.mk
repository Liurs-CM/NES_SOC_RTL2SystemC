.SECONDEXPANSION:
 
TIME_FORMAT=+%s.%N
 
define print_exec_time
    end_time=`date $(TIME_FORMAT)`
    start_time=$$(echo $${end_time%.*} | sed 's/^/-/')
    TZ=UTC0 date -d "@$$(( $(end_time) - $(start_time) ))" $(TIME_FORMAT) | awk -v t="$$(( $(end_time) - $(start_time) ))" '{print $$0"s ("t"s)"}'
endef
 
.PHONY: all
all: target1 target2 target3
 
%:
	@start_time=`date $(TIME_FORMAT)`
	$(MAKE) $@
	$(call print_exec_time)
 
.PHONY: target1 target2 target3
target1:
	@echo Building target1
	sleep 1
 
target2:
	@echo Building target2
	sleep 2
 
target3:
	@echo Building target3
	sleep 3
