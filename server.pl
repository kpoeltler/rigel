#!/usr/bin/perl

use common::sense;
use feature 'signatures';
use AnyEvent;
use AnyEvent::SerialPort;
use AnyEvent::HTTPD;
use AnyEvent::Socket;
use Text::Xslate qw(mark_raw);
use FindBin qw($Bin);
use lib $Bin;
use Config::Tiny;
use Data::Dumper;

main();
exit 0;

sub main
{
	my($httpd, $ra, $dec, $focus );

	print "$Bin/bin/archive/config/csimc.cfg", "\n";
	my $cfg = Config::Tiny->read( "$Bin/bin/archive/config/csimc.cfg" );
	$cfg = $cfg->{_};
	if (! -d "$Bin/cache")
	{
		mkdir("$Bin/cache") or die;
	}
	my $tt = Text::Xslate->new(
		path => "$Bin/template",
		cache_dir => "$Bin/cache",
		syntax => 'Metakolon'
	);

	print "loading csimc scripts...\n";
	# -r reboot, -l load scripts.
	# system('csimc -rl < /dev/null');

	tcp_connect "127.0.0.1", $cfg->{PORT}, sub {
		my ($fh) = @_ or die "csimcd connect failed: $!";

		print "csimcd connected\n";
		$ra = new AnyEvent::Handle(
			fh     => $fh,
			on_error => sub {
				print "csimcd socket error: $_[2]\n";
				$_[0]->destroy;
			},
			on_eof => sub {
				$ra->destroy;
			}
		);
		# addr=0, why=shell=0, zero
		$ra->push_write( pack('ccc', 0, 0, 0) );
		$ra->push_read( chunk => 1, sub($handle, $data) {
				my $result = unpack('C', $data);
				print "RA connect, result: $result\n";
			}
		);

	};



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


sub sendJson
{
	my ($j, $buf, $h, $cookie);

	($j, $cookie) = @_;

	$buf = encode_json($j);
	$h = [
		'Content-Type' => 'application/json; charset=utf-8',
		'Content-Length' => length($buf)
	];
	if ($cookie)
	{
		#		push(@$h, 'Set-Cookie' => bake_cookie(SESSKEY, $cookie));
	}
	return [ 200, $h, [$buf] ];
}

sub showTemplate($tt)
{
	my($file, $vars) = @_;
	#warn("showTemplate $file");

	my $buf;
	$buf = $tt->render($file, $vars);
	return [
		200,
		['Content-Type' => 'text/html; charset=utf-8',
		'Content-Length' => length($buf)],
		[$buf]
	];
}
