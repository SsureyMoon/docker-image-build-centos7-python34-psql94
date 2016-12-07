FROM centos:centos7

MAINTAINER Ssuery Moon (ssureymoon@gmail.com)

RUN yum install -y deltarpm
RUN yum -y update
RUN yum -y groupinstall 'Development Tools'
RUN yum -y install epel-release
RUN yum -y install centos-release-scl
RUN yum -y install wget zlib-devel bzip2-devel openssl-devel libjpeg-devel nano
RUN yum -y install supervisor

# Install Python3.4
RUN yum-builddep -y python
RUN wget -qO-  https://www.python.org/ftp/python/3.4.5/Python-3.4.5.tgz | tar xz
WORKDIR Python-3.4.5
RUN ./configure --prefix=/usr/local
RUN make && make altinstall
WORKDIR ..
RUN rm -rf Python-3.4.5

# Install additional package
RUN yum -y install https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-2.noarch.rpm
RUN yum -y install postgresql94-devel libjpeg-turbo-devel libpq94-devel gcc-c++ python34-devel

# Install Geos
RUN wget -qO- http://download.osgeo.org/geos/geos-3.5.0.tar.bz2 | tar xj
WORKDIR geos-3.5.0
RUN ./configure && make clean && make && make install
RUN ldconfig
WORKDIR ..
RUN rm -rf geos-3.5.0

ENV PATH $PATH:/usr/pgsql-9.4/bin
ENV LD_LIBRARY_PATH=/usr/local/lib

# Install Nodejs
RUN curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
RUN yum -y install nodejs

# Install Ruby and SASS
RUN yum -y install ruby
RUN gem install sass

CMD ["echo", "done installation"]
