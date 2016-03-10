FROM mongo:latest

RUN apt-get update
RUN apt-get install --yes git
RUN apt-get install --yes curl
RUN apt-get install --yes make
RUN apt-get install --yes g++
RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get install --yes nodejs
RUN apt-get install --yes npm

RUN mongodump --host ds049754.mongolab.com:49754 -d heroku_s75tvv20 -u capstone-class -p capstone-2015-2016
RUN git clone https://github.com/MysteryCRU/slocru-keystone.git
RUN cd slocru-keystone/ && git checkout dev
ADD .env slocru-keystone/
RUN cd slocru-keystone/ && npm install

CMD mongod & \
	sleep 2 && \
	mongorestore --host 127.0.0.1 --db slocru dump/heroku_s75tvv20 && \
	cd slocru-keystone/ && \
	npm install request && \
	nodejs keystone.js
