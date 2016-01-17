#!/bin/bash

if [ ! -f /etc/openfire/profile ]; then
	cp -Rfp /etc/openfire-bak/* /etc/openfire
	cp -f /etc/default/openfire /etc/openfire/profile
fi

if [ ! -L /etc/default/openfire ]; then
	rm -f /etc/default/openfire
	ln -s /etc/openfire/profile /etc/default/openfire
fi

chown -Rf openfire:openfire /etc/openfire
chown -Rf openfire:openfire /var/lib/openfire

. /etc/init.d/openfire

sudo -u openfire $JAVA $DAEMON_OPTS
