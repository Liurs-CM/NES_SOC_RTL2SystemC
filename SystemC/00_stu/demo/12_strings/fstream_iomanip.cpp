#include<fstream>
#include<iomanip>
#include<stdlib.h>
#include<iostream>
using namespace std;
int main(){
    // Examples of input
    ifstream infile("my.txt"); //Declare & implicit open
    if (!infile) { // Make sure no open errors
        cerr<< "Unable to read file my.txt!?" <<endl;
        exit(1);
    }//endif
    string first_line;
    infile>>first_line;
    cout<< "first_line='" <<first_line<< "'" <<endl;
    double dave;
    infile>>dave;
    cout<< "dave=" <<setprecision(3) <<dave<<endl;
    infile.close(); // explicit close
                    // Examples of output
    {
        ofstream fout; // Declare - open deferred
        fout.open("save.txt"); // explicit open
        if (!fout) { // Make sure no open errors
            cerr<< "Unable to read file my.txt!?" <<endl ;
            exit(1);
        }//endif
        fout
            <<setw(5) // width of output is five
            <<setfill("#") // filler character is asterisk
            <<first_line.length() // some data
            <<flush// force output buffer to write
                   // notice lack of parens
            ;
    } // Leaving scope destroys output variable,
      // which implicitly closes the file
    return 0;
}
