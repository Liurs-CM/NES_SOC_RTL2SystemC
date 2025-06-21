//FILE:Engine.h
class FuelMix;
class Exhaust;
class Cylinder;
SC_MODULE(Engine) {
    FuelMix* fuelmix_iptr;
    Exhaust* exhaust_iptr;
    Cylinder* cyl1_iptr;
    Cylinder* cyl2_iptr;
    Engine(sc_module_name nm); // Constructor
};
