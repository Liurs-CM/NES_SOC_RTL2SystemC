// Declaration of a class
class Thermometer {
    int m_temp;
    string m_name;
    public:
    // 4 Distinct Constructors
    Thermometer(); // Default constructor
    Thermometer(int val);
    Thermometer(string nm);
    Thermometer(string nm, int val);
    // Ordinary methods
    void set_temp(int val);
    int get_temp();
    void set_name(string nm);
    string get_name();
};
// Definition of methods
Thermometer::Thermometer() {m_name = “unknown”; }
Thermometer::Thermometer(int val) { m_temp = val; }
Thermometer::Thermometer(string nm) { m_name = nm; }
Thermometer::Thermometer(string nm, int val) {
    m_name = nm;
    m_temp = val;
}
void Thermometer::set_temp(int val) {
    m_temp = val;
}
int Thermometer::get_temp() { return m_temp; }
string Thermometer::get_name() { return m_name; }
// Use of a class
int main() {
    Thermometer i1, i2();
    Thermometer i3(15), i4(“inside”),
                i5(“inside”, 72);
    Thermometer i6(‘B’);
}
