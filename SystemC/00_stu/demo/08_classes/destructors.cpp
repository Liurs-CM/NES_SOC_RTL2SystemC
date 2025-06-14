class Pickup {
    public:
        ~Pickup(); // destructor declared
};
Pickup::~Pickup() { // destructor defined
    cout<< “Pickup destroyed” <<endl;
}
