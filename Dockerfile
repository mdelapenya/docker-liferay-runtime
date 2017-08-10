FROM openjdk:8-jdk

LABEL mantainer="José Ángel Jiménez, https://github.com/jcampoy"
LABEL mantainer="Manuel de la Peña, https://github.com/mdelapenya" 

# ------------------------------------------------------------------------ base
RUN set -x \
 && apt-get -qq update     \
 && apt-get -qq upgrade -y \
 && apt-get -qq install -y locales software-properties-common \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

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
