#include <map>
std::map<string, string> cfg;
int sc_main(int argc, char *argv[])
{
    ifstream cf(“sim.cfg”);
    if (!cf) {
        SC_REPORT_FATAL(“EX”,”Unable to read file”);
    } else {
        string inst, model;
        while(cf>>inst) {
            if (cf>>model) {
                cfg[inst] = model;
            }
        }
    } …
};
