#!/bin/sh
# Generate FootLocker Account!


# Use: sh generateAccount.sh -e emailAddressHere

# Sometimes you may see the error 'Requests CSRF Token does not match session'
# If this happens just copy the contents of X-FLAPI-SESSION-ID Header field & paste here. 
# There is definitely a better way to do this in future.
session_id='qxdxniveu5q8181o3h2pi2x2r.fzcexflapipdb638882'

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
csrf_token=$(curl 'https://www.footlocker.com/apigate/v3/session' \
-H 'newrelic: ewoiZCI6IHsKImFjIjogIjI2ODQxODkiLAoiYXAiOiAiODE4MTQxNjY2IiwKImlkIjogIjI1MDA2N2NjNDljNjVmZmQiLAoidGkiOiAxNjM0NjYyNTU4OTYxLAoidHIiOiAiZjVkY2EzMWM4NWZkNjVjOTEzNTJmZTBhNjA1YjAyMmEiLAoidHkiOiAiTW9iaWxlIgp9LAoidiI6IFsKMCwKMgpdCn0=' \
-H 'X-API-KEY: m38t5V0ZmfTsRpKIiQlszub1Tx4FbnGG' \
-H 'X-API-COUNTRY: US' \
-H 'traceparent: 00-f5dca31c85fd65c91352fe0a605b022a-250067cc49c65ffd-00' \
-H 'User-Agent: FootLocker/CFNetwork/Darwin' \
-H 'X-FLAPI-SESSION-ID: '$session_id'' \
-H 'X-NewRelic-ID: VgAPVVdbARAIVVlTAwABUFI=' \
-H 'X-FL-APP-VERSION: 5.4.0' \
-H 'Host: www.footlocker.com' \
-H 'X-FLAPI-API-IDENTIFIER: 921B2b33cAfba5WWcb0bc32d5ix89c6b0f614' \
-H 'X-FL-REQUEST-ID: D0CA33A4-5068-4042-A458-8065064FCB2B' \
-H 'Accept: application/json' \
-H 'X-FL-DEVICE-ID: 9C4DE0DF-FB9B-4848-8DB1-7B5C07B28F8F' \
-H 'X-API-LANG: en-US' \
-H 'tracestate: @nr=0-2-2684189-818141666-250067cc49c65ffd--0--1634662558961' \ | jq -r '.data.csrfToken')
echo "Got token '$csrf_token'"

# Make the create account call with the email, password, firstName, and lastName passed in 
echo "Creating account..."
http_response=$(curl -s -o response.txt -w "%{http_code}" 'https://www.footlocker.com/apigate/v3/users' \
-X POST \
-H 'Accept: application/json' \
-H 'X-API-KEY: m38t5V0ZmfTsRpKIiQlszub1Tx4FbnGG' \
-H 'traceparent: 00-2b8162c896f45c7e431345207918d999-5aa527785b3d56b3-00' \
-H 'X-NewRelic-ID: VgAPVVdbARAIVVlTAwABUFI=' \
-H 'X-FLAPI-API-IDENTIFIER: 921B2b33cAfba5WWcb0bc32d5ix89c6b0f614' \
-H 'tracestate: @nr=0-2-2684189-818141666-5aa527785b3d56b3--0--1632948556450' \
-H 'X-CSRF-TOKEN: '$csrf_token'' \
-H 'X-FLAPI-SESSION-ID: '$session_id'' \
-H 'User-Agent: FootLocker/CFNetwork/Darwin' \
-H 'Content-Type: application/json' \
-H 'FLAKStg: 8034nfdan' \
-H 'newrelic: ewoiZCI6IHsKImFjIjogIjI2ODQxODkiLAoiYXAiOiAiODE4MTQxNjY2IiwKImlkIjogIjVhYTUyNzc4NWIzZDU2YjMiLAoidGkiOiAxNjMyOTQ4NTU2NDUwLAoidHIiOiAiMmI4MTYyYzg5NmY0NWM3ZTQzMTM0NTIwNzkxOGQ5OTkiLAoidHkiOiAiTW9iaWxlIgp9LAoidiI6IFsKMCwKMgpdCn0=' \
-H 'Host: www.footlocker.com' \
-d '{"firstName":"'$firstName'","preferredLanguage":"en","g-recaptcha-response":"03AGdBq25CKR1L9kGr1dyip3_2q6KEGFmC9Q1ws_Xo17BC8X3fSjkrnfNK7a2Aqd2_kLw19w2gAxCw69Udd4di_iSYBgEiAYzNLAznWZZOrJJNQ8kxPmq152-VFZA4GhNjA6omLRjcksHAPkvADqWR2Aq5etE6rPBJlpfV-cjvf7ciCY0SWtxu0rrz6dmtjljwN-ifTBO3D-tRIwoKZ8Hf_2AFsqgkLilQUp0OTzoTg-gKiOCDYgJ4hyoEhxWnhr5QVCLY-txqD8fADGnp8w9rbvtNLYAJssBt_MT2S0k8gPf0adoqRCyKMMkklby5YWPbxeEhVSVx9PZlRl9hXqJPs7o7HmrkejHKHYvRbP0A1Z684gJoA4FxI-peTDi2EwJ3OQZp0-E_XIBkOWUdiA9eIjWlLyx-12vND9GNC-Bo0T4rEU4Ved0kG4gqqWltdQbEg7fxpGzLVu2TV8IjxnEF-eO-cgk9VvlFjeIfdoA7Fg5a9skO6TSPGkQ","loyaltyStatus":false,"bannerEmailOptIn":true,"postalCode":"60610","phoneNumber":"3216549877","uid":"'$email'","password":"'$password'","lastName":"'$lastName'","birthday":"01\/01\/2001"}')

if [ $http_response != "201" ]; then
# if there is an error creating the account, make the same request again so we can see the error output
echo "Error creating account for: '$email'"
curl -sv 'https://www.footlocker.com/apigate/v3/users' \
-X POST \
-H 'Accept: application/json' \
-H 'X-API-KEY: m38t5V0ZmfTsRpKIiQlszub1Tx4FbnGG' \
-H 'traceparent: 00-2b8162c896f45c7e431345207918d999-5aa527785b3d56b3-00' \
-H 'X-NewRelic-ID: VgAPVVdbARAIVVlTAwABUFI=' \
-H 'X-FLAPI-API-IDENTIFIER: 921B2b33cAfba5WWcb0bc32d5ix89c6b0f614' \
-H 'tracestate: @nr=0-2-2684189-818141666-5aa527785b3d56b3--0--1632948556450' \
-H 'X-CSRF-TOKEN: '$csrf_token'' \
-H 'X-FLAPI-SESSION-ID: '$session_id'' \
-H 'User-Agent: FootLocker/CFNetwork/Darwin' \
-H 'Content-Type: application/json' \
-H 'FLAKStg: 8034nfdan' \
-H 'newrelic: ewoiZCI6IHsKImFjIjogIjI2ODQxODkiLAoiYXAiOiAiODE4MTQxNjY2IiwKImlkIjogIjVhYTUyNzc4NWIzZDU2YjMiLAoidGkiOiAxNjMyOTQ4NTU2NDUwLAoidHIiOiAiMmI4MTYyYzg5NmY0NWM3ZTQzMTM0NTIwNzkxOGQ5OTkiLAoidHkiOiAiTW9iaWxlIgp9LAoidiI6IFsKMCwKMgpdCn0=' \
-H 'Host: www.footlocker.com' \
-d '{"firstName":"'$firstName'","preferredLanguage":"en","g-recaptcha-response":"03AGdBq25CKR1L9kGr1dyip3_2q6KEGFmC9Q1ws_Xo17BC8X3fSjkrnfNK7a2Aqd2_kLw19w2gAxCw69Udd4di_iSYBgEiAYzNLAznWZZOrJJNQ8kxPmq152-VFZA4GhNjA6omLRjcksHAPkvADqWR2Aq5etE6rPBJlpfV-cjvf7ciCY0SWtxu0rrz6dmtjljwN-ifTBO3D-tRIwoKZ8Hf_2AFsqgkLilQUp0OTzoTg-gKiOCDYgJ4hyoEhxWnhr5QVCLY-txqD8fADGnp8w9rbvtNLYAJssBt_MT2S0k8gPf0adoqRCyKMMkklby5YWPbxeEhVSVx9PZlRl9hXqJPs7o7HmrkejHKHYvRbP0A1Z684gJoA4FxI-peTDi2EwJ3OQZp0-E_XIBkOWUdiA9eIjWlLyx-12vND9GNC-Bo0T4rEU4Ved0kG4gqqWltdQbEg7fxpGzLVu2TV8IjxnEF-eO-cgk9VvlFjeIfdoA7Fg5a9skO6TSPGkQ","loyaltyStatus":true,"bannerEmailOptIn":true,"postalCode":"60610","phoneNumber":"3216549877","uid":"'$email'","password":"'$password'","lastName":"'$lastName'","birthday":"01\/01\/2001"}'
else
    echo "Account Created for: '$email'"
    cat response.txt
    rm -f response.txt
fi
 