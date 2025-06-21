#include <sstream>
#include <map>
extern std::map<sc_string, sc_string> cfg;
SC_MODULE(mem) {
    mem_arch* mem_arch_i;
    mem_bsyn* mem_bsyn_i;
    …
        SC_HAS_PROCESS(mem);
    explicit mem(sc_module_name nm
            ,unsigned long ba // mem base address
            ,unsigned sz) // mem size
        : sc_channel(nm)
    {
        if (cfg[name()] == "rtl") {
            SC_REPORT_FATAL(MSGID, “RTL not supported”);
        }
        if (cfg[name()] == "bsyn") {
            SC_REPORT_INFO(MSGID, “Configuring bsyn”);
            mem_bsyn_i = new mem_bsyn("mem_bsyn_i",ba,sz);
            // module instantiations and connections
            …
        } else {
            SC_REPORT_INFO(MSGID, “Configuring arch”);
            mem_arch_i = new mem_arch("mem_arch_i",ba,sz);
            …
        }//endif
    }
};
