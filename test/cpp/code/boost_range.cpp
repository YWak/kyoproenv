#include <iostream>
#include <boost/range/irange.hpp>

using namespace std;
using boost::irange;

int main() {
    int n = 0;
    for (int i : irange(1, 4, 1)) {
        n += i;
    }

    cout << n << endl;
}
