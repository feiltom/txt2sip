# txt2sip
Based on work of José Rodrigues
For more information, go to: https://github.com/jrocharodrigues/sipamos

# Usage
Script list file in "data" directory and make a call with text from every file
```
mkdir data
echo '{"phone":"PHONE NUMBER","message":"message voip level3 level4"}' > data/file1
docker run -ti -v $(pwd)/data/:/data/ -e goog_api_key=API_GOOGLE_KEY -e sipsrv=SIP_SRV -e sipid=SIP_ID -e "sippass=SIP_PASSWD" feiltom/txt2sip
```
