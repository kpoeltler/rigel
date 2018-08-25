#!/usr/bin/perl

use common::sense;
use feature 'signatures';
use AnyEvent;
use AnyEvent::SerialPort;
use AnyEvent::HTTPD;


main();
exit 0;

sub main
{
	my $httpd;

	print "init http\n";
	$httpd = AnyEvent::HTTPD->new(
		host => '0.0.0.0',
		port => 9090,
		error => sub { my($e) = @_; print "httpd error: $e\n"; }
	);

	$httpd->reg_cb (
		'/' => \&getRoot,
		'/test' => \&getTest
	);

	my $hdl;
	$hdl = AnyEvent::SerialPort->new(
		serial_port => '/dev/ttyUSB0',
		on_read => \&readSerial
	);

	my $t;
	$t = AnyEvent->timer (
		after => 1,
		interval => 1,
		cb => sub {
			print "timer fired\n";
	  }
	);



	$httpd->run();
}


sub getRoot($httpd, $req)
{
	$req->respond ({ content => ['text/html',
			"<html><body><h1>Hello World!</h1>"
			. "<a href=\"/test\">another test page</a>"
			. "</body></html>"
	]});
}

sub getTest($httpd, $req)
{
	$req->respond ({ content => ['text/html',
		"<html><body><h1>Test page</h1>"
		. "<a href=\"/\">Back to the main page</a>"
		. "</body></html>"
	]});
}

sub readSerial($handle)
{
	my $d = $handle->{rbuf};
	$handle->{rbuf} = '';
	print "SER [$d]\n";
}


