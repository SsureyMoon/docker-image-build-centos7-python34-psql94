FROM ssureymoon/docker-image-build-centos7-python34-psql94:1.2

MAINTAINER Ssuery Moon (ssureymoon@gmail.com)

RUN yum -y install alsa-lib-devel

RUN npm cache clean
RUN npm install node-gyp@"^3.5" -g

ADD base_requirements.txt /tmp/base_requirements.txt

RUN pip3.4 install -r /tmp/base_requirements.txt

CMD ["echo", "done installation"]
