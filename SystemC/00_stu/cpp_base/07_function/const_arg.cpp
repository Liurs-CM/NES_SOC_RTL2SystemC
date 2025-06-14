#include <vector>
#include <iostream>
using namespace std;
typedef std::vector<int>::const_iterator
vint_iterator;
int average(std::vector<int> const & v){
    int sum(0);
    for (vint_iterator i=v.begin();i!=v.end();++i) {
        sum += *i;
    }//endfor
    return sum/v.size();
}
int main(){
    std::vector<int> nums = {1, 2, 3, 4, 5};
    int a = average(nums);
    cout << "nums' average: "  << a << endl;
    return 0;
}
