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
	);
	$httpd->reg_cb(
		error => sub { my($e) = @_; print "httpd error: $e\n"; },
		request => \&webRequest
	);

	my $hdl;
	$hdl = AnyEvent::SerialPort->new(
		serial_port => '/dev/ttyUSB0',
		on_read => \&readSerial
	);

	my $t;
	$t = AnyEvent->timer (
		after => 1,
		#interval => 1,
		cb => sub {
			print "timer fired\n";
	  }
	);



	$httpd->run();
}


sub webRequest($httpd, $req)
{
	my $buf = "<html><body>name = " . $req->parm('name') . '<br> method = ' . $req->method
		. '<br>path = ' . $req->url->path;

	$req->respond ({ content => ['text/html', $buf]});
}


sub readSerial($handle)
{
	my $d = $handle->{rbuf};
	$handle->{rbuf} = '';
	exit if (! $d);
	print "SER [$d]\n";
}


