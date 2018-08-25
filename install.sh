#!/usr/bin/bash

# one time: curl -L https://cpanmin.us | perl - --sudo App::cpanminus
/usr/local/bin/cpanm  --skip-installed \
	File::Temp  \
	common::sense \
	Config::Tiny \
	JSON::XS \
	DBI \
	DBD::SQLite \
	RPi::WiringPi \
	EV \
	AnyEvent \
	AnyEvent::SerialPort \
	AnyEvent::HTTPD \





