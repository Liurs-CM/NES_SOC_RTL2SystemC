next_trigger(time);
next_trigger(timeout,time_unit); //convenience
next_trigger(event);
next_trigger(event1 | eventi…); //any of these
next_trigger(event1 & eventi…); //all of these required
next_trigger(timeout,event); //event with timeout
next_trigger(timeout,event1 | eventi…);//any +
next_trigger(timeout,event1 & eventi…);//all + timeout
timeout
next_trigger(void); //re-establish static sensitivity
