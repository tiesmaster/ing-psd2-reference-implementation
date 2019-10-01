#!/usr/bin/env bash
reqDate=`LC_TIME=en_US.UTF-8 date -u "+%a, %d %b %Y %H:%M:%S GMT"`

clientID="e77d776b-90af-4684-bebc-521e5b2614dd"

httpMethod="post"
reqPath="/oauth2/token"

body="grant_type=client_credentials&scope=greetings%3Aview"
digest=$(echo -n ${body} | openssl dgst -binary -sha256 | openssl base64)

reqId=`powershell -Command "[guid]::NewGuid().ToString()"`

signingString1="(request-target): ${httpMethod} ${reqPath}"
signingString2="date: ${reqDate}"
signingString3="digest: SHA-256=${digest}"
signingString4="x-ing-reqid: ${reqId}"

signingString="${signingString1}"$'\n'"${signingString2}"$'\n'"${signingString3}"$'\n'"${signingString4}"

signature=`printf "${signingString}" | openssl dgst -sha256 -sign ./example_client_signing.key -passin "pass:changeit" | openssl base64 -A`

response=`curl -X POST --silent --cert example_client_tls.cer --key example_client_tls.key \
-H "Date: ${reqDate}" \
-H "Digest: SHA-256=${digest}" \
-H "X-ING-ReqID: ${reqId}" \
-H "Authorization: Signature keyId=\"${clientID}\",algorithm=\"rsa-sha256\",headers=\"(request-target) date digest x-ing-reqid\",signature=\"${signature}\"" \
-H "Content-Type: application/x-www-form-urlencoded" \
-d ${body} \
https://api.ing.com/oauth2/token`

reqDate=`LC_TIME=en_US.UTF-8 date -u "+%a, %d %b %Y %H:%M:%S GMT"`

httpMethod="get"
reqPath="/greetings/single"

body=""
digest=$(echo -n ${body} | openssl dgst -binary -sha256 | openssl base64)

reqId=`powershell -Command "[guid]::NewGuid().ToString()"`

signingString1="(request-target): ${httpMethod} ${reqPath}"
signingString2="date: ${reqDate}"
signingString3="digest: SHA-256=${digest}"
signingString4="x-ing-reqid: ${reqId}"

signingString="${signingString1}"$'\n'"${signingString2}"$'\n'"${signingString3}"$'\n'"${signingString4}"

signature=`printf "${signingString}" | openssl dgst -sha256 -sign ./example_client_signing.key -passin "pass:changeit" | openssl base64 -A`

accessToken=$(echo ${response} | json access_token)

response2=`curl -X GET --silent --cert example_client_tls.cer --key example_client_tls.key \
-H "Date: ${reqDate}" \
-H "Digest: SHA-256=${digest}" \
-H "X-ING-ReqID: ${reqId}" \
-H "Authorization: Bearer ${accessToken}" \
-H "Signature: keyId=\"${clientID}\",algorithm=\"rsa-sha256\",headers=\"(request-target) date digest x-ing-reqid\",signature=\"${signature}\"" \
-H "Content-Length: 0" \
-H "Accept: application/json" \
https://api.ing.com/greetings/single`  2> /dev/null

message=$(echo ${response2} | json message)
id=$(echo ${response2} | json id)
messageTimestamp=$(echo ${response2} | json messageTimestamp)

echo $message " at " $messageTimestamp " with id " $id
