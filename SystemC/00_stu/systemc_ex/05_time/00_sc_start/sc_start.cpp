//FILE: main.cpp
int sc_main(int argc, char* argv[]) { // args unused
    basic_process_ex my_instance("my_instance");
    sc_start(60.0,SC_SEC); // Limit sim to one minute
    return 0;
}

//FILE: main.cpp
int sc_main(int argc, char* argv[]) {// args unused
    sc_set_time_resolution(1,SC_MS);
    basic_process_ex my_instance("my_instance");
    sc_start(7200,SC_SEC); // Limit simulation to 2 hours (or 7200 secs.)
    double t = sc_time_stamp(); //max is 7200 x 10**3
    unsigned hours = int(t / 3600.0);
    t -= 3600.0*hours;
    unsigned minutes = int(t / 60.0);
    t -= 60.0*minutes;
    double seconds = t;
    cout<< hours<< " hours "
        << minutes<< " minutes "
        << seconds<< " seconds" //to the nearest ms
        << endl;
    return 0;
}
