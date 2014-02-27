#!/usr/bin/perl
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    norminator                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmarbeuf <cmarbeuf@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/12/03 21:34:01 by cmarbeuf          #+#    #+#              #
#    Updated: 2013/12/08 21:48:03 by cmarbeuf         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

use Getopt::Std;
use Getopt::Long;
use HTTP::Request::Common;
use HTTP::Cookies;
use LWP::UserAgent;
use Term::ReadKey;
use strict;

my %opts;
my %cfg;
my $ua = LWP::UserAgent->new;
$cfg{'no_libc'}		= 0;		# default: on
$cfg{'no_printf'}	= 0;		# default: on
$cfg{'no_extras'}	= 0;		# default: off
$cfg{'only_errors'}	= 0;		# default: off
$cfg{'filename'}	= '/tmp/norminator.tar';
$cfg{'username'}	= defined($ENV{'USER'}) ? $ENV{'USER'} : 'nobody';
$cfg{'hostname'}	= `hostname`;
chop($cfg{'hostname'});

$ua->cookie_jar(HTTP::Cookies->new(file => $ENV{'HOME'} .'/.norminator', autosave => 1, ignore_discard => 1));
$ua->agent('Norminator v1.0 client at '. $cfg{'username'} .'@'. $cfg{'hostname'});
$ua->timeout(30);
GetOptions('auth' => \$cfg{'auth'}, 'libc!' => \$cfg{'no_libc'}, 'printf!' => \$cfg{'no_printf'}, 'extras!' => \$cfg{'no_extras'}, 'errors' => \$cfg{'only_errors'});

unlink($ENV{'HOME'} .'/.norminator') if ($cfg{'auth'});
login() if (! -e $ENV{'HOME'} .'/.norminator');

die "Usage: norminator.pl [options] <one or more file/directory>\n".
	"	Options:\n".
	"	--auth (set/reset authentification)\n\n".
	"	--nolibc or --nolibc (enable/disable checks for nolibc)\n".
	"	--printf or --noprintf (enable/disable checks for printf)\n".
	"	--extras or --noextras (enable/disable extras infos)\n\n".
	"	--errors (display only errors)\n" unless($ARGV[0]);

if ($#ARGV eq 0 && !-d $ARGV[0])
{
	$cfg{'filename'} = $ARGV[0];
}
else
{
	system("tar cf /tmp/norminator.tar ". join(' ', @ARGV));
	die "\033[38;5;1m => TAR has returned an error, aborting. ($?)\033[0m\n" if ($? ne 0);
}

&post();
unlink('/tmp/norminator.tar') if (-e '/tmp/norminator.tar');

sub login
{
	print "\033[38;5;3m => First step, you need to fill your norminator username and password\033[0m\n";
	print "Username:\n";
	my $username = <>;
	chomp($username);
	print "Password:\n";
	ReadMode ('noecho');
	my $password = <>;
	ReadMode ('restore');
	chomp($password);
	my $res = $ua->post('http://norminator.clem.org/core/modules/auth.php', Content => [ op => 'login', username => $username, password => $password ]);
	if (!$res->is_success || $res->content =~ /Invalid/)
	{
		unlink($ENV{'HOME'} .'/.norminator') if (-e $ENV{'HOME'} .'/.norminator');
		die "\033[38;5;1m => /!\\ Invalid login details.\033[0m\n";
	}
	print "\033[38;5;2m => Logged in.\033[0m\n";
}

sub	post
{
	print "\033[38;5;3m => Checking $cfg{'filename'} ...\033[0m\n";
	my $res = $ua->post('http://norminator.clem.org/', Content_Type => 'form-data', Content => [
		client => 1, no_libc => $cfg{'no_libc'}, no_printf => $cfg{'no_printf'}, extra_infos => $cfg{'no_extras'}, only_errors => $cfg{'only_errors'}, filedata => [ $cfg{'filename'} ]
	]);
	die "\033[38;5;1m => Error while sending data\033[0m\n" if (!$res->is_success);
	print $res->content ."\n";
}
