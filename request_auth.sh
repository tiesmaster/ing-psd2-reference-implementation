reqDate=`LC_TIME=en_US.UTF-8 date -u "+%a, %d %b %Y %H:%M:%S GMT"`
ING_URL="https://api.ing.com"

httpMethod="post"
reqPath="/oauth2/token"

body="grant_type=client_credentials&scope=granting+greetings%3Aview"
digest=$(echo -n ${body} | openssl dgst -binary -sha256 | openssl base64)

reqId=`uuidgen`

signingString="(request-target): ${httpMethod} ${reqPath} date: ${reqDate} digest: SHA-256=${digest} x-ing-reqid: ${reqId}"

signature=`printf "${signingString}" | openssl dgst -sha256 -sign ./http/server.key | openssl base64 -A`

curl -v -i -X POST --cert ./tls/server_public.crt --key ./tls/server.key \
-H "Accept: application/json, application/json, application/*+json, application/*+json" \
-H "Content-Type: text/plain;charset=UTF-8" \
-H "Digest: SHA-256=${digest}" \
-H "Date: ${reqDate}" \
-H "X-ING-ReqID: ${reqId}" \
-H "Signature: keyId=\"72e7c36f-9ef1-444b-938c-8af9fa2c9fff\",algorithm=\"rsa-sha256\",headers=\"(request-target) date digest x-ing-reqid\",signature=\"${signature}\"" \
--data "${body}" \
https://api.ing.com/oauth2/token 
