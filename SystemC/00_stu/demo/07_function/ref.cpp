#include<iostream>
using namespace std;

void advance(int & var, int max = 10){
    if (var == max) var = 0;
    else ++var;
}

int main(){
    int n(5); // n starts at 5

    while (n != 4){
        cout << "n is " << n << endl;
        advance(n);
    }//endwhile
    return 0;
}
