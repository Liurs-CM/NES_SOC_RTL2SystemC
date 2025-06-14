#include<iostream>
using namespace std;
// Declaration of a class
class Thermometer {
    int m_temp;
    string m_name;
    public:
    void set_temp(int val);
    int get_temp();
    void set_name(string nm);
    string get_name();
};
// Definition of member functions
void Thermometer::set_temp(int val) {
    m_temp = val;
}
int Thermometer::get_temp() { return m_temp; }
void Thermometer::set_name(string nm) {
    m_name = nm;
}
string Thermometer::get_name() { return m_name; }
// Use of a class
#include<iostream>
int main(int argc, char *argv[]) {
    Thermometer dashboard;
    dashboard.set_temp(27);
    dashboard.set_name("inside");
    cout << dashboard.get_name() << "="
        << dashboard.get_temp() << "℃" << endl;
}
