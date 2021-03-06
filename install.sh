#!/usr/bin/bash

# one time: curl -L https://cpanmin.us | perl - --sudo App::cpanminus
/usr/local/bin/cpanm  --skip-installed \
	File::Temp  \
	common::sense \
	Config::Tiny \
	JSON::XS \
	DBI \
	DBD::SQLite \
	EV \
	AnyEvent \
	AnyEvent::SerialPort \
	AnyEvent::HTTPD \
	AnyEvent::Socket \
	Text::Xslate \
	HTTP::XSCookies \
	Text::CSV_XS \

# XSCookies requires Date::Parse



