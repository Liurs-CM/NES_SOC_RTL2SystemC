//FILE: basic_process_ex.cpp
void basic_process_ex::my_thread_process(void) {
    cout << "my_thread_process executed within "
        << name() //returns sc_module instance name
        << endl;
}
