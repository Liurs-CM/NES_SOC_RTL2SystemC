#include<iostream>
#include<string>
using namespace std;

class Error {
    public:
        string message;
        short value;
        Error(string msg, short val)
            :message(msg)
             , value(val)
    {}
};

short div(short a, short b) {
    short result = 0;
    try {
        if (a > 150) {
            throw Error("Bad value: a=",a);
        } else if (b == 0 or b > 150) {
            throw Error("Bad value: b=",b);
        }
        result =a/b;
    }
    catch (Error what) {
        cout<<what.message<<what.value<<endl;
    }
    catch (...) {
        cout<< "Something bad happened in div" <<endl;
        throw;
    }
    return result;
}
