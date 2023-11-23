FROM ubuntu:jammy
ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Use bash instead of sh.
SHELL ["/bin/bash", "-c"]

# Use the default UTF-8 language.
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y apache2 && apt-get install -y php && apt-get install -y libapache2-mod-php php-curl php-json && apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 80 443

COPY myapp/. /var/www/html/

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
