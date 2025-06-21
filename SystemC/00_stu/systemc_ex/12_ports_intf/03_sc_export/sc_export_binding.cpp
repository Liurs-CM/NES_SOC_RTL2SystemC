SC_MODULE(modulename) {
    sc_export<interface> xportname;
    module minstance;
    SC_CTOR(modulename)
        , minstance("minstance")
        {
            xportname(minstance.subxport);
        }
};
