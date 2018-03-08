
exec &> "./grade-info.md"

deductions=""

return=0
test_count=0
in_test=false

echo "# Grade Information"
echo

test_start() {
    if [[ ${in_test} == true ]]; then
        echo "FATAL: Entering test block failed: missing 'test_end'?"
        exit 1
    fi
    in_test=true
    ((test_count++))
    echo "## Test ${test_count}: ${1}"
    if [[ -n ${2} ]]; then
        echo
        echo "${2}"
    fi
    echo
    echo '```'
    exec &> "./grade-info.md.test.${test_count}"
    trace_on
}

test_end() {
    return=${?}
    { trace_off; } 2> /dev/null
    exec >> "./grade-info.md" 2>&1
    cat "./grade-info.md.test.${test_count}"
    output=$(cat "./grade-info.md.test.${test_count}" | sed '/^\+/d')
    rm -f "./grade-info.md.test.${test_count}"
    if [[ -z "${output}" ]]; then
        lines=0
    else
        lines=$(wc -l <<< "${output}")
    fi
    echo "+ [Output Lines: ${lines}]"
    in_test=false
    echo -e '```'"\n"
}

test_deduct() {
    deduction="* (Test ${test_count}): ${1}"$'\n'
    deductions="${deductions}${deduction}"
}

trace_on() {
    set -x
}

trace_off() {
    { set +x; } 2> /dev/null
}

print_deductions() {
    echo
    echo "## Deductions"
    echo
    echo "${deductions}"
}


