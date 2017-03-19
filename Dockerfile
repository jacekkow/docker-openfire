FROM debian
MAINTAINER Jacek Kowalski <Jacek@jacekk.info>

ENV OPENFIRE_VERSION 4.1.1

RUN echo 'deb http://httpredir.debian.org/debian jessie-backports main' > \
		/etc/apt/sources.list.d/jessie-backports.list \
	&& apt-get -y update \
	&& apt-get -y -t jessie-backports install openjdk-8-jre-headless wget sudo \
	&& apt-get -y clean

RUN cd /tmp \
	&& wget -O openfire.deb "https://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_${OPENFIRE_VERSION}_all.deb" \
	&& dpkg -i openfire.deb \
	&& sed -i 's/exit/return/' /etc/init.d/openfire \
	&& cp -Rp /etc/openfire /etc/openfire-bak \
	&& rm openfire.deb

VOLUME /etc/openfire
VOLUME /var/lib/openfire/embedded-db
EXPOSE 5222 5223 5269 9090 9091

ADD run.sh /
CMD /run.sh
