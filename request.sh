reqDate=`LC_TIME=en_US.UTF-8 date -u "+%a, %d %b %Y %H:%M:%S GMT"`

httpMethod="get"
reqPath="/greetings/single"
clientID="72e7c36f-9ef1-444b-938c-8af9fa2c9fff"

body=""
digest=$(echo -n ${body} | openssl dgst -binary -sha256 | openssl base64)

reqId=`uuidgen`

signingString1="(request-target): ${httpMethod} ${reqPath}"
signingString2="date: ${reqDate}"
signingString3="digest: SHA-256=${digest}"
signingString4="x-ing-reqid: ${reqId}"

signingString="${signingString1}"$'\n'"${signingString2}"$'\n'"${signingString3}"$'\n'"${signingString4}"

signature=`printf "${signingString}" | openssl dgst -sha256 -sign ./http.key -passin "pass:jtkirk01" | openssl base64 -A`

accessToken="eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIiwia2lkIjoicHJkLThlZTk0NTIzLTAxNjMtNDMyZi1hYjgwLWFhNjU4MTFhNDBmYiIsImN0eSI6IkpXVCJ9..PJOHoOlVrrOWnajnkrSvxQ.YWI_GktlSYMR-Pbe8xiGUCFDhzI4Imd0iFF77OEecBT0vudqA7uti4PigqJuCGOlrapx1BRA2bUhh87hAp86hB85z03lEwsrCe3F8sZ1fX2s89SgJfzV0qEXwoIz6JuMQZYhbMw8leX6xMCw8A7sFXcXspLwcS4rnrChYovUpkFBCpJiuwdqYZezMbeKliCPs2Z3w9zdlGL2HePG_nvT9w_Xz13NNFhhyW5XSl43FH_n3ftcag20v_BLm4__i2Ll8WHhtbtvtha0BL0vemz7SNDqCYfX8HIMye7GeL_KjeMvs8NX8cq7DR0bdyJxlSfniTkldg7KivqFqzJG7MwDv742RBiqJt2lgkgzjiZza8Rwsc3EpBjSUzl1pk-4xAvHw1sWjE0ggTAb8ph9iZDZrVm-If494EUxQ2H9wzNAIHrZ3zRIB9xO0eOuN8i8tA63RhWWPe6jaa9Sv41ffuotUJDx0YhExxpsvNpqaIFajwsCDk8C4mxah4lfzh_rZomcpQthhe59oRdTOJ2DVNaXEVSdVmv8rRU2-b2-dht7-owr6MiRr9Jf_uRO-dwklZb1WQ-9BGUw43DHpS5DC6wxMRwfRZ9y_EPBbnGMtT74Hfs0Fb6b1czpOWYvx_KpFYOBSw4MA6smXotVuWyTe-yc1yR5CEN6veAFTl10ilMtjOoYxnWUg4CAo8mTCl7etlPbd_9dCc65fPD8--sSrnf1i29uGcjoo-Zi8hi_fApxhOKiZUn1kwknZTOnOBJ2oUhh8ceo6NGwwiWX0Z6ey99DrCz-kkVbGZlQQvsbQCyXblRXCKx0Wq2QGA8HbTvMsGLxDnsjDjtiXKTmRjE4U1_ON4hzZoMX-xkzbzxmm4Cm40GuUVF4XQ6hXL58DBS1qzVi44c2xEhBLHrWnjwEwSsxTqFx-qryMHL0JNddP2ngpbq-ouVgifE-eguhXOa9iqBhtymdF_nt9mUd_vY9wVG5mEcRbdENYgisSWQ1w4jLfBzuM2-XicC9l88Oi9PKxntWuKXBpztVy1zerfHvfdShF-fPgShK-MYvFRva2uQw8Ht8OP4HtrhBoLLksqi4BzEDQEVtbizdHao0jsZJr0jlrbpW2VJ8avCn7juCQtvhnzeAmK1oP7W6yN1X1y0y3mkGvK40imzab9NU6TqD5rIiWrj4wOKJsNjwVmi_nwhXqAt_abQqhcFx-t0m4XScy2UGZaXXjsAUgsZgKTmCCVLKbkuKHnjnyLnI-kXGkvSSHBpiBaA9NqQlhd3KdNs3jH67dPYd0FQNH4_epCACEbdc-TcmuI6Ep5xn9gRyMul1KZ8aU7wH7NrFqc2KGk1IfwVmujb-mtYmAjjGpOR7uZMi6gcetrMCPyPMm0KmnZAncUIJHFmqPPlNPQT8geIwHWq26PmaGvCSPS0Be8MennSw9gFCv9aWJ4BwSfRjCFLFcHpEIBYGiGcBuUhmx-Jf0Vc479SNP_WAKj2wS7vjx1rPC0H3LqjGnsBV69BxNtqvRJ-v0cAV8A2vp0hmYFgFUJ6b2PbLq3_zFijEn8pGWewBcOU_w4mXjDCVDBEZ_eYW0Qixi92j82vclcDEvHqdaXqOPZsZBy6E2Gt_VucLqmtgvK0k66OO_cErz0MII7nmZeGBuJOCUu2wezi70l06AEDYWrZL86XSo6ZeviZcgmUoArN9AeBEJrcSY-OcpDckyIBECKJT2pMqj0mQ2pDxqcgQl5WLQdTwg1eFJc1wSQ30hd9hgfZHBJ3wK0pkwyrptbYmQgBNKzY2Mba-6gy4eJdLkZpQwgfpwvu5ofpAxggclSUDZcW_BNb2V37G9j3Oj-2P5EdHiS-CsDF0g5kyokefD3yqRH7UUQ_X_caUeqqIlGAIMyNw9vD1BT4EKf7Sr7_8I-pbAudIZvAc-shu5lm-QiSp3qicTQ7LOLl1bOoeaqDtTn-jnriXjgfH-njQNrRTah0Ae35S0nyh-ajl6PLDsQYhAMjcFEGQtFbzBXIAyO7dG82r0Bj-m2G5qfAJ1uDeH_qcqJ_w-oOlWOqVEWVF55zNX2A-OmFZsy9Y3LgbUEpHhrm_fP4uXHa90IB2QgZGeI6I-I9BEOMOUC1_n7BVEgXIqzQ52RBEwVwGTEeWriVYtgxX6hOOpNvjufTQF5kEOuY2c4-HG418XYakAdWcOOWAPRrpkuTBzzy58OR-EdxbyrpnvZCeEZvThgFTJBTSzDywcI1WVcIhliV07oNDDzvTxYCCp19SA33nyqRorA.V7YrYDSFGymC70IHc9-YxN8EDtVgLGJw5FFDAomNEIw"

curl -v -i -X GET --cert tls_public.crt --key tls.key \
-H "Date: ${reqDate}" \
-H "Digest: SHA-256=${digest}" \
-H "X-ING-ReqID: ${reqId}" \
-H "Authorization: Bearer ${accessToken}" \
-H "Signature: keyId=\"${clientID}\",algorithm=\"rsa-sha256\",headers=\"(request-target) date digest x-ing-reqid\",signature=\"${signature}\"" \
-H "Content-Length: 0" \
-H "Accept: application/json" \
https://api.ing.com/greetings/single

