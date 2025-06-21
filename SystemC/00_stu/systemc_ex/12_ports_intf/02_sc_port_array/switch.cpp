//FILE: Switch.cpp
void Switch::switch_thread() {
    // Initialize requests
    for (unsigned i=0;i!=request_op.size();i++) {
        request_op[i]->write(true);
    }//endfor
     // Startup after first port is activated
    wait(    T1_ip[0]->data_written_event()
            |T1_ip[1]->data_written_event()
            |T1_ip[2]->data_written_event()
            |T1_ip[3]->data_written_event()
        );
    while(true) {
        for (unsigned i=0;i!=T1_ip.size();i++) {
            // Process each port...
            int value = T1_ip[i]->read();
        }//endfor
    }//endwhile
}//end Switch::switch_thread
