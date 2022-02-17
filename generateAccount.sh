#!/bin/sh
# Generate FootLocker Account!


# Use: sh generateAccount.sh -e emailAddressHere

# Sometimes you may see the error 'Requests CSRF Token does not match session'
# If this happens just copy the contents of X-FLAPI-SESSION-ID Header field & paste here. 
# There is definitely a better way to do this in future.
session_id='bjnp5ox5xmlqsy2khrzv5i46.fzcexflapiua418880'

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
csrf_token=$(curl -s 'https://www.uat2.origin.footaction.com/zgw/session' \
-H 'Host: www.uat2.origin.footaction.com' \
-H 'traceparent: 00-8630f76c1a43644c9dc2d1c3fc67e166-a98bc2efed5a1ff4-00' \
-H 'X-API-KEY: opkwGnFiyvsl0m6VfHGX3dFlWkFBzkJN' \
-H 'X-FLAPI-API-IDENTIFIER: 921B2b33cAfba5WWcb0bc32d5ix89c6b0f614' \
-H 'X-FLAPI-RESOURCE-IDENTIFIER: ffa7e0ea-49ce-4172-9583-092832b2cbea' \
-H 'X-API-COUNTRY: US' \
-H 'X-FLAPI-TIMEOUT: 57579' \
-H 'User-Agent: Footaction/CFNetwork/Darwin' \
-H 'X-FLAPI-CART-GUID: 89d5c681-8261-46aa-a79d-0f66740ea223' \
-H 'X-NewRelic-ID: VgAPVVdbARAIVVlTAgEOUFQ=' \
-H 'tracestate: @nr=0-2-2684189-818150960-a98bc2efed5a1ff4--0--1645049742732' \
-H 'FLAKStg: 8034nfdan' \
-H 'newrelic: ewoiZCI6IHsKImFjIjogIjI2ODQxODkiLAoiYXAiOiAiODE4MTUwOTYwIiwKImlkIjogImE5OGJjMmVmZWQ1YTFmZjQiLAoidGkiOiAxNjQ1MDQ5NzQyNzMyLAoidHIiOiAiODYzMGY3NmMxYTQzNjQ0YzlkYzJkMWMzZmM2N2UxNjYiLAoidHkiOiAiTW9iaWxlIgp9LAoidiI6IFsKMCwKMgpdCn0=' \
-H 'X-API-LANG: en-US' \
-H 'Accept: application/json' \
-H 'X-FLAPI-SESSION-ID: '$session_id'' \ | jq -r '.data.csrfToken')
echo "Got token '$csrf_token'"

# Make the create account call with the email, password, firstName, and lastName passed in 
echo "Creating account..."
http_response=$(curl -s -o response.txt -w "%{http_code}" 'https://www.uat2.origin.footaction.com/apigate/v3/users' \
-X POST \
-H 'Host: www.uat2.origin.footaction.com' \
-H 'X-ZGWID: eyJhbGciOiJIUzUxMiJ9.eyJndWVzdElkIjoiZmVkZTM2Y2EtNWQ3Yy00MWVhLWE5ZjYtOWFkOWU3N2Q4OTc4IiwiaWF0IjoxNjQ1MDU1NzY0LCJleHAiOjE2NzY1OTE3NjR9.MQ4GAmeNSvHmAExHqW9qcBFOXtItJGdYWdBjdy_6LJ6TqommAd4iZTxI_OWjL7xegP6bTg0L2CHOdBUJCiwkEg' \
-H 'X-FLAPI-API-IDENTIFIER: 921B2b33cAfba5WWcb0bc32d5ix89c6b0f614' \
-H 'X-NewRelic-ID: VgAPVVdbARAIVVlTAgEOUFQ=' \
-H 'X-API-COUNTRY: US' \
-H 'X-CSRF-TOKEN: '$csrf_token'' \
-H 'X-API-LANG: en-US' \
-H 'X-FLAPI-SESSION-ID: '$session_id'' \
-H 'User-Agent: Footaction/CFNetwork/Darwin' \
-H 'X-API-KEY: opkwGnFiyvsl0m6VfHGX3dFlWkFBzkJN' \
-H 'FLAKStg: 8034nfdan' \
-H 'newrelic: ewoiZCI6IHsKImFjIjogIjI2ODQxODkiLAoiYXAiOiAiODE4MTUwOTYwIiwKImlkIjogIjlhMzYwNmFhMzY2NGMwNzciLAoidGkiOiAxNjQ1MDU1ODAyODYxLAoidHIiOiAiNTM4MDY3YTI5MDM3NDkyODdjYmZhYmJjNWJjNzI0MTYiLAoidHkiOiAiTW9iaWxlIgp9LAoidiI6IFsKMCwKMgpdCn0=' \
-H 'Accept: application/json' \
-H 'tracestate: @nr=0-2-2684189-818150960-9a3606aa3664c077--0--1645055802861' \
-H 'traceparent: 00-538067a2903749287cbfabbc5bc72416-9a3606aa3664c077-00' \
-H 'Content-Type: application/json' \
-H 'X-ZGWID: eyJhbGciOiJIUzUxMiJ9.eyJndWVzdElkIjoiOGRkZmQyMmQtMjkwZi00YjY2LThlYTQtYjMxMTM2NDVmNDFkIiwiaWF0IjoxNjQ1MDUyNzAzLCJleHAiOjE2NzY1ODg3MDN9.t3EFn_-8JrUk2It9x0Dk5kyRqT6tsxiyDPLF5ReJcHVN4Gcl1f0bpfJg3ut1i7Kd5BucRsMFFlzckfdQUTlG6w' \
-d '{"loyaltyFlxEmailOptIn":true,"firstName":"'$firstName'","preferredLanguage":"en","g-recaptcha-response":"03AGdBq25c63pWRqI2W5RLCB4mnbkYQM7j35QBB4mCOYasU7shajXAl1PXh_OSRwwsmxoI2UwQvgh6DZzlmO6E0enL1HYEtTFT0nkQFRKecFuVDjj1it5NtBz53eEOhdYnKPlje7o-rA-BdRixv9wuaOuCHi8SM3249DzFiXuh9ATUVif8xCZBYJhV8aU6Wjcc_NjAovKBzjjc1mq6Oq1uNOtbmpYkKCLG-86H6wU3TEZ8aoBy3JpgGTppixggqTuHwsuqTYXHr4Km6d0UA6xSGMaJtQ3MlYM5GzEYGipZarXU77HXGOBIBP6v4hdOZrTaPzqRaOtOKZEqDcd8-w6x_nN1cmV0Yl18OXJYeRs3UrxPGccORGGwSKypYYBBOZ_W__G72Z6xVo1f6DnUU8n_1UzwKfWPP3gFzR8Hn8ftof-Bq4Y6mjkx995G959EvhlTMCxAFUScWgp0JJhEFpQn31mStYyXhMIaKw","loyaltyStatus":false,"bannerEmailOptIn":true,"postalCode":"60610","phoneNumber":"3216549877","uid":"'$email'","password":"'$password'","lastName":"'$lastName'","birthday":"01\/01\/2001","flxTcVersion":"1.0"}')

if [ $http_response != "201" ]; then
# if there is an error creating the account, make the same request again so we can see the error output
echo "Error creating account for: '$email'\n"

curl -s 'https://www.uat2.origin.footaction.com/apigate/v3/users' \
-X POST \
-H 'Host: www.uat2.origin.footaction.com' \
-H 'X-ZGWID: eyJhbGciOiJIUzUxMiJ9.eyJndWVzdElkIjoiZmVkZTM2Y2EtNWQ3Yy00MWVhLWE5ZjYtOWFkOWU3N2Q4OTc4IiwiaWF0IjoxNjQ1MDU1NzY0LCJleHAiOjE2NzY1OTE3NjR9.MQ4GAmeNSvHmAExHqW9qcBFOXtItJGdYWdBjdy_6LJ6TqommAd4iZTxI_OWjL7xegP6bTg0L2CHOdBUJCiwkEg' \
-H 'X-FLAPI-API-IDENTIFIER: 921B2b33cAfba5WWcb0bc32d5ix89c6b0f614' \
-H 'X-NewRelic-ID: VgAPVVdbARAIVVlTAgEOUFQ=' \
-H 'X-API-COUNTRY: US' \
-H 'X-CSRF-TOKEN: '$csrf_token'' \
-H 'X-API-LANG: en-US' \
-H 'X-FLAPI-SESSION-ID: '$session_id'' \
-H 'User-Agent: Footaction/CFNetwork/Darwin' \
-H 'X-API-KEY: opkwGnFiyvsl0m6VfHGX3dFlWkFBzkJN' \
-H 'FLAKStg: 8034nfdan' \
-H 'newrelic: ewoiZCI6IHsKImFjIjogIjI2ODQxODkiLAoiYXAiOiAiODE4MTUwOTYwIiwKImlkIjogIjlhMzYwNmFhMzY2NGMwNzciLAoidGkiOiAxNjQ1MDU1ODAyODYxLAoidHIiOiAiNTM4MDY3YTI5MDM3NDkyODdjYmZhYmJjNWJjNzI0MTYiLAoidHkiOiAiTW9iaWxlIgp9LAoidiI6IFsKMCwKMgpdCn0=' \
-H 'Accept: application/json' \
-H 'tracestate: @nr=0-2-2684189-818150960-9a3606aa3664c077--0--1645055802861' \
-H 'traceparent: 00-538067a2903749287cbfabbc5bc72416-9a3606aa3664c077-00' \
-H 'Content-Type: application/json' \
-H 'X-ZGWID: eyJhbGciOiJIUzUxMiJ9.eyJndWVzdElkIjoiOGRkZmQyMmQtMjkwZi00YjY2LThlYTQtYjMxMTM2NDVmNDFkIiwiaWF0IjoxNjQ1MDUyNzAzLCJleHAiOjE2NzY1ODg3MDN9.t3EFn_-8JrUk2It9x0Dk5kyRqT6tsxiyDPLF5ReJcHVN4Gcl1f0bpfJg3ut1i7Kd5BucRsMFFlzckfdQUTlG6w' \
-d '{"loyaltyFlxEmailOptIn":true,"firstName":"'$firstName'","preferredLanguage":"en","g-recaptcha-response":"03AGdBq25c63pWRqI2W5RLCB4mnbkYQM7j35QBB4mCOYasU7shajXAl1PXh_OSRwwsmxoI2UwQvgh6DZzlmO6E0enL1HYEtTFT0nkQFRKecFuVDjj1it5NtBz53eEOhdYnKPlje7o-rA-BdRixv9wuaOuCHi8SM3249DzFiXuh9ATUVif8xCZBYJhV8aU6Wjcc_NjAovKBzjjc1mq6Oq1uNOtbmpYkKCLG-86H6wU3TEZ8aoBy3JpgGTppixggqTuHwsuqTYXHr4Km6d0UA6xSGMaJtQ3MlYM5GzEYGipZarXU77HXGOBIBP6v4hdOZrTaPzqRaOtOKZEqDcd8-w6x_nN1cmV0Yl18OXJYeRs3UrxPGccORGGwSKypYYBBOZ_W__G72Z6xVo1f6DnUU8n_1UzwKfWPP3gFzR8Hn8ftof-Bq4Y6mjkx995G959EvhlTMCxAFUScWgp0JJhEFpQn31mStYyXhMIaKw","loyaltyStatus":false,"bannerEmailOptIn":true,"postalCode":"60610","phoneNumber":"3216549877","uid":"'$email'","password":"'$password'","lastName":"'$lastName'","birthday":"01\/01\/2001","flxTcVersion":"1.0"}'
else
    echo "Account Created for: '$email'"
    cat response.txt
    rm -f response.txt
fi
 