reqDate=`LC_TIME=en_US.UTF-8 date -u "+%a, %d %b %Y %H:%M:%S GMT"`

httpMethod="post"
reqPath="/oauth2/token"

body="grant_type=client_credentials&scope=greetings%3Aview"
digest=$(echo -n ${body} | openssl dgst -binary -sha256 | openssl base64)

reqId=`uuidgen`

signingString1="(request-target): ${httpMethod} ${reqPath}" 
signingString2="date: ${reqDate}"
signingString3="digest: SHA-256=${digest}"
signingString4="x-ing-reqid: ${reqId}"

signingString="${signingString1}"$'\n'"${signingString2}"$'\n'"${signingString3}"$'\n'"${signingString4}"

signature=`printf "${signingString}" | openssl dgst -sha256 -sign ./http.key -passin "pass:jtkirk01" | openssl base64 -A`

curl -v -X POST --cert tls_public.crt --key tls.key \
-H "Date: ${reqDate}" \
-H "Digest: SHA-256=${digest}" \
-H "X-ING-ReqID: ${reqId}" \
-H "Authorization: Signature keyId=\"72e7c36f-9ef1-444b-938c-8af9fa2c9fff\",algorithm=\"rsa-sha256\",headers=\"(request-target) date digest x-ing-reqid\",signature=\"${signature}\"" \
-H "Content-Type: application/x-www-form-urlencoded" \
-d ${body} \
https://api.ing.com/oauth2/token

