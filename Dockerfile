FROM ubuntu:trusty

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update -qq
RUN apt-get upgrade -qqy

RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
RUN apt-get install nodejs -y

RUN apt-get update -qq

# make the src folder available in the docker image
ADD . /src
#WORKDIR /src
# Bundle app source
COPY . /src

# install the dependencies from the package.json file
RUN cd /src; npm install

# make port 80 available outside of the image
EXPOSE 80

# start node with the index.js file of our hello-world application
CMD ["node", "/src/index.js"]
