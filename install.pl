#!/usr/bin/perl
use strict;
use CPAN;

my @list = qw(
File::Temp
common::sense
Config::Tiny
JSON::XS
DBI
DBD::SQLite
RPi::WiringPi
);


for my $x (@list)
{
	CPAN::Shell->install($x);
}


