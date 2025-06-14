class Tire {
    unsigned m_size;
    public:
    Tire(unsigned size) { m_size = size; }
    unsigned size() {return m_size; }
};
class Allweather
: public Tire // inherit from Tire class
{
    int traction;
    public:
    Allweather(int size);
    int friction();
};

//Overriding Inheriterd Member Functions
class Tire {
    unsigned m_size;
    public:
    Tire(unsigned size) { m_size = size; }
    unsigned size() { return m_size; }
};
class Allweather
: public Tire
{
    int traction;
    public:
    Allweather(int size):Tire(size){};
    int friction();
    //Overriding
    unsigned size() {
        cout<< “overrides Tire’s size()” <<endl;
        return m_size+1;
    }
};
