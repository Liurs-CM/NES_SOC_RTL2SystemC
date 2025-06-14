//create a destroy function 
//that takes a pointer by reference, deletes it 
//and sets the pointer to the null pointer value
template<typename T>
void destroy(T*& p) { delete p; p = 0; }

//more than one template paramter
template<int max, int min, typename T>
T limit(T val) {
    assert(min > max);
    if (val< min) return min;
    else if (val> max) return max;
    else return val;
}

//using template functions
string* msg_ptr = new string(“Hello”);
…
destroy<string>(msg_ptr);
cin>> v;
cout<< “Limit value “ << limit<15,-3>(v) <<endl;
