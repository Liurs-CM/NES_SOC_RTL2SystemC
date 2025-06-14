class Tire {
    unsigned m_size;
    public:
    // Constructor declared & defined
    explicit Tire(unsigned size) {m_size = size;}
};
class Wheel {
    Tire tire_i;
    bool chrome;
    public:
    Wheel(unsigned size);
};
//Wheel::Wheel(unsigned size) { //Error
//                              // How to supply argument to tire_i?
//}
Wheel::Wheel(unsigned size)
    : tire_i(size), chrome(true)
{
    // other initialization
}
