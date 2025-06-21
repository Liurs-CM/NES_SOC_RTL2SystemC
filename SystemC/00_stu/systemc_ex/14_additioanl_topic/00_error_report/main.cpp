const char* MSGID = "/ESLX/Examples/mysim";
const char* sim_vers = "Version 5.2"; // Code version
int sc_main(int argc, char* argv[]) {
    sc_report rp;
    sc_report_handler::set_log_file_name("run.log");
    sc_report_handler::stop_after(SC_ERROR, 100);
    sc_report_handler::set_actions(
            MSGID, SC_INFO, SC_DISPLAY|SC_LOG
            );
    SC_REPORT_INFO(MSGID,sim_vers);
    …/* Body of main */
        sc_start();
    if (sc_report_handler::get_count(SC_ERROR) > 0
            || sc_report_handler::get_count(SC_FATAL)
       )
    {
        cout << rp.->get_msg() << endl;
        cout << MSGID << " FAILED" << endl;
        return 1;
    } else {
        cout << MSGID << " PASSED" << endl;
        return 0;
    }
}
