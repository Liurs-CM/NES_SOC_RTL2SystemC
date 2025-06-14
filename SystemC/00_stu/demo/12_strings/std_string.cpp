#include<iostream>
using namespace std;
int main(){
    string mesg("Hello SystemC!");
    mesg += " I concatenate";
    cout
        <<mesg<<endl
        << "length=" <<mesg.length() <<endl
        << "substr(6,6)=" <<mesg.substr(6,6) <<endl
        << "find(\"stem\")=" <<mesg.find("stem") <<endl
        << "mesg[12]=" <<mesg[12] <<endl
        ;
    // Convert to C-style string for use with printf
    printf("%s\n", mesg.c_str());
    return 0;
}
