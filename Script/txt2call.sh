export IP_PUB=`curl -s ifconfig.me|grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}"`
while [ 1 ]; do
for mess in /data/*
 do
        if [ ! "$mess" = "/data/*" ]
        then
        NUMBER=`cat $mess|jq .phone|sed "s/\"//g"`
        MESSAGE=`cat $mess|jq .message|sed "s/\"//g"|sed "s/'//g"`
        echo $MESSAGE
        curl -H "X-Goog-Api-Key: ${goog_api_key}" \
          -H "Content-Type: application/json; charset=utf-8" \
          --data "{
            'input':{
              'text':'${MESSAGE}'
            },
            'voice':{
              'languageCode':'fr-fr',
              'name':'fr-FR-Wavenet-A'
            },
            'audioConfig':{
              'audioEncoding':'LINEAR16'
            }
          }" "https://texttospeech.googleapis.com/v1beta1/text:synthesize" > test4.txt


        sed 's|audioContent| |' < test4.txt > tmp-output.txt && \
        tr -d '\n ":{}' < tmp-output.txt > tmp-output-2.txt && \
        base64 tmp-output-2.txt --decode > message.wav && \
        rm tmp-output*.txt
        python2.7 sipamos.py $NUMBER
        rm $mess
      fi
done
sleep 5
done
exit 0
