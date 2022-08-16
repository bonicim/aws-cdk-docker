FROM ubuntu:20.04
#
USER root
#
# Do not allow interaction
ENV DEBIAN_FRONTEND=noninteractive

COPY . .
#
# Update and Upgrade then install wget
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install wget
#
# Get deb package repo for installing dotnet-sdk-3.1
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb
#
# update so we can install the new packages
# needed such as pip3
# install node and some utilities like unzip and curl
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install python3-pip python3-venv unixodbc-dev apt-transport-https nodejs dotnet-sdk-3.1 && \
    apt-get -y install npm libpq-dev curl unzip zip jq less
#
# Update node to 14 from NodeSource because aws-cdk >=2.28.0 requires V14+
# See https://github.com/aws/aws-cdk/commit/d0a27c15d66c00aef9288d514498d68e8f0d886a
# and https://linuxize.com/post/how-to-install-node-js-on-ubuntu-20-04/
#
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs
#
# installing aws-cdk versiion 2.36.0
# when updating aws cdk we need to increment
# this variable.
#
RUN npm install -g aws-cdk@2.36.0
#
# install python packages needed for cicd scripts 
#
RUN pip3 install boto3 psycopg2 'aws-cdk-lib==2.23.0' 'constructs>=10.0.0,<11.0.0'
#
# install aws cli
#
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install
RUN alias pip=pip3
RUN alias python=python3
CMD [ "/bin/bash" ]
