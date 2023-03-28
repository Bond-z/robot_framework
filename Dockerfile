FROM alpine:latest AS dl

WORKDIR /

RUN apk add curl unzip --update

RUN curl -sO https://dl-ssl.google.com/linux/linux_signing_key.pub
RUN export CHROMEDRIVER_VERSION=`curl -s https://chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    curl -sO http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip
    

FROM python:3.7-slim

COPY --from=dl /linux_signing_key.pub .
COPY --from=dl /chromedriver /usr/local/bin/chromedriver

RUN apt-get update && \
    apt-get install --no-install-recommends gnupg fonts-tlwg-loma fonts-tlwg-loma-otf -y -q


RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-key add linux_signing_key.pub && \
    apt-get update && \
    apt-get install --no-install-recommends google-chrome-stable -y -q && \
    rm -f linux_signing_key.pub && \
    chmod +x /usr/local/bin/chromedriver
  
# RUN pip install robotframework==3.1.2 robotframework-seleniumlibrary==4.3.0 robotframework-selenium2library==3.0.0 robotframework-appiumlibrary==1.5.0.7 robotframework-pabot==1.11 robotframework-databaselibrary==1.2.4 robotframework-requests==0.6.6 pyYAML==3.13 PyMySQL==1.0.2 robotframework-csvlibrary-py3==1.0.2

## Try install requirements.txt
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
