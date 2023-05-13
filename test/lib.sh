#!/bin/bash

testsize=0
test_ok=0
test_ng=0

trap ':' 0

_trap_push () {
    prev=$(trap -p 0 | sed -E -e "s/^trap -- '(.+)' EXIT/\1/")
    trap "${prev}; $1" 0
}

_it () {
    _trap_push "rm -f \$out"
    out=$(mktemp)

    testname="$1"
    shift

    testsize=$(( testsize + 1 ))
    docker run --rm -it -u user -w /tests "$IMAGE_NAME" "$@" 1>$out 2>&1

    if [ $? = 0 ]; then
        test_ok=$(( test_ok + 1 ))
        echo "$testname ... OK"
    else
        test_ng=$(( test_ng + 1 ))
        echo "$testname ... NG"
    fi
    cat $out
}

_show_results () {
    echo "$test_ok / $testsize tests are succeeded"
}
