#!/bin/sh
# Add a store to the footlocker UAT CMS!

curl --location --request POST 'https://fzeu2-cexlrs-li-uat-sbn-01.servicebus.windows.net/launch_stores/Messages?api-version=2016-07' \
--header 'Content-Type: application/json' \
--header 'authorization: SharedAccessSignature sr=fzeu2-cexlrs-li-uat-sbn-01.servicebus.windows.net&sig=RgAjB5vKKE8JzD6wP1GpndiAXXCmGjJOgPBjBgONC88%3D&se=1659624778&skn=CI_Send_key' \
--header 'cache-control: no-cache' \
--header 'host: fzeu2-cexlrs-li-uat-sbn-01.servicebus.windows.net' \
--data-raw '{
"sku": "776859",
"store": "0306972", //Chicago Store
"status": "ADD"
}'