#define SC_INCLUDE_DYNAMIC_PROCESSES
#include <systemc>

void spawned_thread() {// This will be spawned
    cout << "INFO: spawned_thread "
        << sc_get_current_process_handle().name()
        << " @ " << sc_time_stamp() << endl;
    wait(10,SC_NS);
    cout << "INFO: Exiting" << endl;
}

void simple_spawn::main_thread() {
    wait(15,SC_NS);
    // Unused handle discarded
    sc_spawn(sc_bind(&spawned_thread));
    cout << "INFO: main_thread " << name()
        << " @ " << sc_time_stamp() << endl;
    wait(15,SC_NS);
    cout << "INFO: main_thread stopping "
        << " @ " << sc_time_stamp() << endl;
}

sc_process_handle h =
sc_spawn(sc_bind(&spawned_thread));
// Do some work …
// Wait for spawned thread to return
wait(h.terminated_event());
