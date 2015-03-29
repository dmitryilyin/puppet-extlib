#!/bin/bash

echo "Verifying that no function in extlib collides with a stdlib function"

rm -fr puppetlabs-stdlib
git clone https://github.com/puppetlabs/puppetlabs-stdlib

stdlib_funcs=`echo puppetlabs-stdlib/lib/puppet/parser/functions/*`
extlib_funcs=`echo lib/puppet/parser/functions/*`
failed_bit=0

for ext_func in $extlib_funcs
do
    for std_func in $stdlib_funcs
    do
        ext=`basename $ext_func`
        std=`basename $std_func`
        if [ "${std}" = "${ext}" ]; then
            echo "Error: Function $ext found in both modules!"
            failed_bit=1
        fi
    done
done

if [ failed_bit = 1 ]; then
    echo "At least one function exists in both extlib and stdlib"
    echo "Failed test"
    exit 1
fi
