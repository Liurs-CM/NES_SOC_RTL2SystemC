bool uint_option(string opt, unsigned &value) {
    string arg;
    for (unsigned i=1; i!=sc_argc(); ++i) {
        arg = sc_argv()[i];
        if (arg.find(opt,0) != 0) continue;
        if (arg.length() == 0) continue;
        arg.erase(0,opt.length());
        if (isdigit(arg[0])) {
            istringstream ins(arg);
            ins >> value;
            return true;
        }//endif
    }//endfor
    return false;
} …
// usage
if (uint_option("-n=", n)) {
    size = n;
}//endif
