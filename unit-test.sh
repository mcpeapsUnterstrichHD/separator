# Here are some informal unit tests

# The following should have successful output

sep.sh

sep.sh --sep =
sep.sh -s =
sep.sh -s +-
sep.sh -s \<\>-
sep.sh -s output--
sep.sh -s '- unit test 7 -'

sep.sh --box 1
sep.sh -b 2
sep.sh -b 05 
sep.sh -b 8
sep.sh -b 9

sep.sh -v
sep.sh --version

sep.sh -h
sep.sh -?
sep.sh --help

# The following should have errors

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

