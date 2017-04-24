FROM       ubuntu:16.04
MAINTAINER go1020 "https://github.com/"

RUN apt-get update

RUN apt-get install -y openssh-server
RUN apt-get install -y screen
RUN mkdir /var/run/sshd

RUN echo "root:E4mdQ8g${DEFAULT_PW}" |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/^#PasswordAuthentication\s+.*/PasswordAuthentication no/' /etc/ssh/sshd_config
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**

EXPOSE 22
CMD ["/run.sh"]
