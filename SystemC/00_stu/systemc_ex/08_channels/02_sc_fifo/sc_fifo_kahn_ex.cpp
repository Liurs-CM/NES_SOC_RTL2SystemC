SC_MODULE(kahn_ex) {
    …
        sc_fifo<double> a, b, y;
    …
};
// Constructor
kahn_ex::kahn_ex() : a(24), b(24), y(48)
{
    …
}
void kahn_ex ::stim_thread() {
    for (int i=0; i!=1024; ++i) {
        a.write(double(rand()/1000));
        b.write(double(rand()/1000));
    }
}
void kahn_ex::addsub_thread() {
    while(true) {
        y.write(kA*a.read() + kB*b.read());
        y.write(kA*a.read() - kB*b.read());
    }//endforever
}
void kahn_ex::monitor_method() {
    cout << y.read() << endl;
}
