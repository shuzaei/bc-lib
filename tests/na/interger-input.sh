#!/bin/bash

id="na/integer-input"
in=(
    "abcdefgh12345678ABCDEFGH\n"
)
out=(
    "0000000012345678\n"
)

root="$(dirname "$0")/../.."

bcc "$root/$id.bc" "$root/$id"
flag=true
for ((i = 0; i < ${#in[@]}; i++)) {
    diff <("$root/$id" < <(printf "${in[i]}")) <(printf "${out[i]}") \
    && printf "[test %d/%d] \e[92mOK\e[0m\n" $(($i+1)) ${#in[@]}\
    || printf "[test %d/%d] \e[91mFAILED\e[0m\n" $(($i+1)) ${#in[@]} && flag=false
}
[[ $flag ]] && printf "\e[92mOK\e[0m\n" || printf "\e[91mFAILED\e[0m\n"
[[ $flag ]]
