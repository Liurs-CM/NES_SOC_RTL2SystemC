#include<iostream>
#include<systemc>
using namespace std;
using namespace sc_core;

SC_MODULE(basic_process_ex) {
    int count;
    string message_temp;
    sc_signal<int> count_sig;
    sc_signal<string> message_sig;

    SC_CTOR(basic_process_ex) {
        SC_THREAD(my_thread_process);
    }
    void my_thread_process(void);
};

void basic_process_ex::my_thread_process(void) {
    cout << "my_thread_process executed within "
        << name() //returns sc_module instance name
        << endl;

    cout << "Initialize during 1st delta cycle" << endl;
    count_sig.write(10);
    message_sig.write("Hello");
    count = 11;
    message_temp = "Whoa";
    cout << "[1]count is " << count << " "
        << "[1]count_sig is " << count_sig << endl
        << "[1]message_temp is '" << message_temp << "' "
        << "[1]message_sig is '" << message_sig << "'"
        << endl << "Waiting" << endl << endl;
    wait(SC_ZERO_TIME);

    cout << "2nd delta cycle" << endl;
    count = 20;
    count_sig.write(count);
    cout << "[2]count is " << count << ", "
        << "[2]count_sig is " << count_sig << endl
        << "[2]message_temp is '" << message_temp << "', "
        << "[2]message_sig is '" << message_sig << "'"
        <<endl << "Waiting" << endl << endl;
    wait(SC_ZERO_TIME);

    cout << "3rd delta cycle" << endl;
    message_sig.write(message_temp = "Rev engines");
    cout << "[3]count is " << count << ", "
        << "[3]count_sig is " << count_sig << endl
        << "[3]message_temp is '" << message_temp << "', "
        << "[3]message_sig is '" << message_sig << "'"
        << endl << endl << "Done" << endl;
}

int sc_main(int argc, char* argv[]) { // args unused
    basic_process_ex my_instance("my_instance");
    sc_start();
    return 0; // unconditional success (not recommended)
}
