#include<sstream>
#include<iostream>
#include<iomanip>
// First examine an output string stream
using namespace std;

int main(){
    ostringstream sout;
    sout << "Use I/O to create strings" <<endl;
    sout << hex << 1234 << endl;
    sout <<setprecision(3)<< 4.9 << endl;
    // Extract the string
    string mesg = sout.str();

    // Now try an input string stream
    mesg = "height 5.78";
    istringstream sin;
    sin.str(mesg);
    int i;
    sin>> i >> mesg;
    cout << "Field:" << mesg << " Value:"<< i << endl;
    return 0;
}
