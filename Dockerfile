FROM python:2.7-stretch

RUN apt-get update
RUN apt-get install -y python-dev gcc make gcc binutils build-essential libasound2-dev jq
RUN rm -rf /var/lib/apt/lists/*


RUN mkdir /work
WORKDIR /work
RUN wget http://www.pjsip.org/release/2.6/pjproject-2.6.tar.bz2
RUN tar -xjf pjproject-2.6.tar.bz2
RUN cd pjproject-2.6;export CFLAGS="$CFLAGS -fPIC";./configure
RUN cd pjproject-2.6;export CFLAGS="$CFLAGS -fPIC";make dep
RUN cd pjproject-2.6;export CFLAGS="$CFLAGS -fPIC";make
RUN cd pjproject-2.6;cd pjsip-apps/src/python/;python setup.py install

RUN mkdir /data
#COPY test/sdqdqd-qsddqdq /data/sqdqsdqsd-dqdsq-3323
COPY Script/sipamos.py /work/sipamos.py
COPY Script/txt2call.sh /work/txt2call.sh
CMD [ "sh", "/work/txt2call.sh" ]
