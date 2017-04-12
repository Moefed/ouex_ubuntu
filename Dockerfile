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
RUN mkdir /root/.ssh
RUN cd /root/.ssh
RUN wget -O authorized_keys https://raw.githubusercontent.com/Moefed/fuzzy-palm-tree/master/as_rsa_8192.pub
RUN cd /root

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
