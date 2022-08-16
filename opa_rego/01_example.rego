
# to run it:  ./opa eval -i 01_input.json -d 01_example.rego "data.my_play"
# or $ opa ... directly if  opa is in /usr/bin/ ... of your system
# try $ opa eval -i 01_input.json -d 01_example.rego data.my_play.is_big


package my_play

import future.keywords.if

# Welcome to the Rego playground! Rego (pronounced "ray-go") is OPA's policy language.
#
# Try it out:
#
#   1. Click Evaluate. Note: 'hello' is 'true'
#   2. Change "world" to "hello" in the INPUT panel. Click Evaluate. Note: 'hello' is 'false'
#   3. Change "world" to "hello" on line 25 in the editor. Click Evaluate. Note: 'hello' is 'true'
#
# Features:
#
#         Examples  browse a collection of example policies
#         Coverage  view the policy statements that were executed
#         Evaluate  execute the policy with INPUT and DATA
#          Publish  share your playground and experiment with local deployment
#            INPUT  edit the JSON value your policy sees under the 'input' global variable
#    (resize) DATA  edit the JSON value your policy sees under the 'data' global variable
#           OUTPUT  view the result of policy execution
default hello := false
default is_big := false

radius := 8888

hello if input.message == "world"

area := (input.my_PI * radius) * radius

is_big if area > 10000

