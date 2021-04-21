#!bash

for test in $(find ./tests -name 'test-*.js'); do
    k6 run $test
done
