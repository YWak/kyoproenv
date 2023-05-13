#include <iostream>
#include <atcoder/modint>

using namespace std;
using namespace atcoder;

using mint = modint998244353;

int main() {
    mint s = 2;

    s.pow(100);

    cout << s.val() << endl;
}
