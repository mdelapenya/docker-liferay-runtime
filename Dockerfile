FROM debian:jessie

LABEL mantainer="Manuel de la Peña, https://github.com/mdelapenya" 
LABEL mantainer="José Ángel Jiménez, https://github.com/jcampoy"

ENV JAVA_HOME="/opt/jdk"

ENV \
  JRE_HOME="$JAVA_HOME/jre" \
  PATH="$JAVA_HOME/bin:$PATH"
# ------------------------------------------------------------------------ base
RUN set -x && \
  apt update -y && \
  apt upgrade -y && \
  apt-get -qq install -y \
    curl locales software-properties-common tree && \
  curl -L -k --output oraclejdk.tar.gz -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz && \
  tar -xzf oraclejdk.tar.gz && \
  mv /jdk1* $JAVA_HOME && \
  rm -f /oraclejdk.tar.gz

# ------------------------------------------------------------------------ utf-8
## Set LOCALE to UTF8
ENV DEBIAN_FRONTEND=noninteractive 
ENV LC_ALL en_US.UTF-8

RUN set -x \
	&& echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
	&& locale-gen en_US.UTF-8 \
  	&& dpkg-reconfigure locales

# Define default command.
CMD ["bash"]
