FROM debian:jessie

LABEL mantainer="José Ángel Jiménez, https://github.com/jcampoy"
LABEL mantainer="Manuel de la Peña, https://github.com/mdelapenya" 

# ------------------------------------------------------------------------ base
RUN apt-get -qq update     \
 && apt-get -qq upgrade -y \
 && apt-get -qq install -y locales curl unzip curl software-properties-common \
 && apt-get clean

# ------------------------------------------------------------------------ java8
RUN (curl -L -k -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz | gunzip -c | tar x) \
 &&  mv /$(find / -type d -maxdepth 1 -name "jdk1*" | awk -F / '{print $NF}') /opt/jdk 

ENV JAVA_HOME /opt/jdk
ENV JRE_HOME  $JAVA_HOME/jre
ENV PATH $PATH:$JAVA_HOME/bin

# ------------------------------------------------------------------------ utf-8
## Set LOCALE to UTF8
ENV DEBIAN_FRONTEND=noninteractive 
ENV LC_ALL en_US.UTF-8

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
	locale-gen en_US.UTF-8 &&\
  	dpkg-reconfigure locales

# ----------------------------------------------------------------------- workdir
# Define working directory.
WORKDIR /opt

# Define default command.
CMD ["bash"]
