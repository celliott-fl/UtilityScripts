#!/bin/sh
# Generate FootLocker Account!


# Use: sh generateAccount.sh -e emailAddressHere

# Sometimes you may see the error 'Requests CSRF Token does not match session'
# If this happens just copy the contents of X-FLAPI-SESSION-ID Header field & paste here. 
# There is definitely a better way to do this in future.
session_id='bl2wqb6cz584lsobobaeimi7.fzcxwefapiua018880'

# Defaults
password='Asdf1234!'
firstName='Mint'
lastName='Lav'

while getopts e: flag
do
    case "${flag}" in
        e) email=${OPTARG};;
    esac
done
echo "Email: $email";

# Fetch the session and pull from it the csrf_toen for the create account request
echo "Fetching Session..."
csrf_token=$(curl 'https://www.uat7.origin.footlocker.co.uk/apigate/v5/session' \
-H 'Accept-Language: en-GB,en;q=0.9' \
-H 'X-API-COUNTRY: GB' \
-H 'X-NewRelic-ID: VgAPVVdbARAIVVlTDwkFX1Q=' \
-H 'FLAKStg: 8034nfdan' \
-H 'Accept: application/json' \
-H 'X-FLAPI-SESSION-ID: '$session_id'' \
-H 'X-FLAPI-API-IDENTIFIER: 921B2b33cAfba5WWcb0bc32d5ix89c6b0f614' \
-H 'User-Agent: FLEU/CFNetwork/Darwin' \
-H 'X-API-KEY: SA3yBizlATIdz3S8FLd21lLIckfblbmI' \
-H 'X-API-LANG: en-GB' \
-H 'tracestate: @nr=0-2-2684189-818188290-0ce9dfdf3f615b2a--0--1634575075060' \
-H 'traceparent: 00-d7e1a299829f41aef557fd875d3cde0f-0ce9dfdf3f615b2a-00' \
-H 'Host: www.uat7.origin.footlocker.co.uk' \
-H 'newrelic: ewoiZCI6IHsKImFjIjogIjI2ODQxODkiLAoiYXAiOiAiODE4MTg4MjkwIiwKImlkIjogIjBjZTlkZmRmM2Y2MTViMmEiLAoidGkiOiAxNjM0NTc1MDc1MDYwLAoidHIiOiAiZDdlMWEyOTk4MjlmNDFhZWY1NTdmZDg3NWQzY2RlMGYiLAoidHkiOiAiTW9iaWxlIgp9LAoidiI6IFsKMCwKMgpdCn0=' \
 | jq -r '.data.csrfToken')
echo "Got token '$csrf_token'"


# Make the create account call with the email, password, firstName, and lastName passed in 
echo "Creating account..."
http_response=$(curl 'https://www.uat7.origin.footlocker.co.uk/apigate/v5/users' \
-X POST \
-H 'X-API-COUNTRY: GB' \
-H 'traceparent: 00-c9ce7b28f2d9e3ced5976c54e3cc225b-f30dc742bea9bebc-00' \
-H 'X-NewRelic-ID: VgAPVVdbARAIVVlTDwkFX1Q=' \
-H 'Host: www.uat7.origin.footlocker.co.uk' \
-H 'User-Agent: FLEU/CFNetwork/Darwin' \
-H 'FLAKStg: 8034nfdan' \
-H 'X-FLAPI-API-IDENTIFIER: 921B2b33cAfba5WWcb0bc32d5ix89c6b0f614' \
-H 'newrelic: ewoiZCI6IHsKImFjIjogIjI2ODQxODkiLAoiYXAiOiAiODE4MTg4MjkwIiwKImlkIjogImYzMGRjNzQyYmVhOWJlYmMiLAoidGkiOiAxNjM0NTc1MDc3NTUyLAoidHIiOiAiYzljZTdiMjhmMmQ5ZTNjZWQ1OTc2YzU0ZTNjYzIyNWIiLAoidHkiOiAiTW9iaWxlIgp9LAoidiI6IFsKMCwKMgpdCn0=' \
-H 'tracestate: @nr=0-2-2684189-818188290-f30dc742bea9bebc--0--1634575077552' \
-H 'X-API-KEY: SA3yBizlATIdz3S8FLd21lLIckfblbmI' \
-H 'Content-Type: application/json' \
-H 'Accept-Language: en-GB,en;q=0.9' \
-H 'Accept: application/json' \
-H 'X-CSRF-TOKEN: '$csrf_token'' \
-H 'X-API-LANG: en-GB' \
-H 'X-FLAPI-SESSION-ID: '$session_id'' \
-d '{"country":{"isocode":"gb","name":"en-GB"},"uid":"'$email'","loyaltyStatus":false,"password":"Asdf1234!","preferredLanguage":"en","firstName":"'$firstName'","termsAndCondition":true,"birthday":"01\/01\/2001","bannerEmailOptIn":false,"gender":"Male","phoneNumber":"","lastName":"'$lastName'","postalCode":""}')


if [ $http_response != "201" ]; then
# if there is an error creating the account, make the same request again so we can see the error output
echo "Error creating account for: '$email'"
curl 'https://www.uat7.origin.footlocker.co.uk/apigate/v5/users' \
-X POST \
-H 'X-API-COUNTRY: GB' \
-H 'traceparent: 00-c9ce7b28f2d9e3ced5976c54e3cc225b-f30dc742bea9bebc-00' \
-H 'X-NewRelic-ID: VgAPVVdbARAIVVlTDwkFX1Q=' \
-H 'Host: www.uat7.origin.footlocker.co.uk' \
-H 'User-Agent: FLEU/CFNetwork/Darwin' \
-H 'FLAKStg: 8034nfdan' \
-H 'X-FLAPI-API-IDENTIFIER: 921B2b33cAfba5WWcb0bc32d5ix89c6b0f614' \
-H 'newrelic: ewoiZCI6IHsKImFjIjogIjI2ODQxODkiLAoiYXAiOiAiODE4MTg4MjkwIiwKImlkIjogImYzMGRjNzQyYmVhOWJlYmMiLAoidGkiOiAxNjM0NTc1MDc3NTUyLAoidHIiOiAiYzljZTdiMjhmMmQ5ZTNjZWQ1OTc2YzU0ZTNjYzIyNWIiLAoidHkiOiAiTW9iaWxlIgp9LAoidiI6IFsKMCwKMgpdCn0=' \
-H 'tracestate: @nr=0-2-2684189-818188290-f30dc742bea9bebc--0--1634575077552' \
-H 'X-API-KEY: SA3yBizlATIdz3S8FLd21lLIckfblbmI' \
-H 'Content-Type: application/json' \
-H 'Accept-Language: en-GB,en;q=0.9' \
-H 'Accept: application/json' \
-H 'X-CSRF-TOKEN: '$csrf_token'' \
-H 'X-API-LANG: en-GB' \
-H 'X-FLAPI-SESSION-ID: '$session_id'' \
-d '{"country":{"isocode":"gb","name":"en-GB"},"uid":"'$email'","loyaltyStatus":false,"password":"Asdf1234!","preferredLanguage":"en","firstName":"'$firstName'","termsAndCondition":true,"birthday":"01\/01\/2001","bannerEmailOptIn":false,"gender":"Male","phoneNumber":"","lastName":"'$lastName'","postalCode":""}'
else
    echo "Account Created for: '$email'"
    cat response.txt
    rm -f response.txt
fi
 