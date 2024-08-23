# Here are some informal unit tests

# The following should have successful output

echo "\x1b[32mThe following should have successful output\x1b[0m"

echo "sep.sh"
sep.sh
echo "sep.sh --sep"
sep.sh --sep =
echo "sep.sh -s ..."
sep.sh -s =
sep.sh -s +-
sep.sh -s \<\>-
sep.sh -s output--
sep.sh -s '- unit test 7 -'

echo "sep.sh -box ..."

sep.sh --box 1
echo "sep.sh -b ..."
sep.sh -b 2
sep.sh -b 05
sep.sh -b 8
sep.sh -b 9

echo "sep.sh -v"
sep.sh -v
echo "sep.sh --version"
sep.sh --version

echo "sep.sh -h"
sep.sh -h
echo "sep.sh -?"
sep.sh -?
echo "sep.sh --help"
sep.sh --help

# The following should have errors

echo "\x1b[31mThe following should have errors\x1b[0m"


sep.sh -x
sep.sh 5

sep.sh -s
sep.sh --sep

sep.sh -b
sep.sh --box

sep.sh -b x
sep.sh -b 0
sep.sh -b 10

sep.sh -s = -b 4

# To do: should either have an error or handle both options

# sep.sh -h -v
# sep.sh -v -h
