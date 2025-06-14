//Defining namespaces
namespace your_name {
    your_code
}

//Using names and namespaces
using your_name::identifier; //for a single variable
using namespace your_name; // to include all names
using namespace std; //should only use in .cpp files

//Anonymous namespaces
void func1(void) {
    // Cannot use hidden or secret() here, because
    // they have not been defined yet
}
namespace {
    int hidden(42);
    int secret(int v) { return v+7; }
}
int func2(void) {
    // OK to use hidden and secret, since they've
    // been defined previously.
    return hidden * secret(3);
}
