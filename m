From: Noel Hunt <huntno@ubs.com>
Subject: autofs not mounting directories
Date: Tue, 16 Mar 2004 12:58:30 +0900
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200403160358.MAA25667@tk3p108pos.tky.swissbank.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>

I have been given reports by users that after a reboot,
cron jobs don't run, and also sudo su - ..., while not
failing, is not cd'ing to the user's home directory. In
the cron case, there were commands of the form

/a/b/cmd > /a/b/log 2>&1

(/a/b being an automount point) where one would expect
the modify time of /a/b/log to change even if the command
fails, but the files modification times were unchanged from
the last access.

I was also told that a cd from the shell to the directory
in question solves the problem.

The machines on which this is reported had no cron logging
which I have now remedied, so I can't try to reproduce this
until I can reboot these machines.

If `directory' is an automount mountpoint, is there some
difference between `cd directory', and say cron running
`/directory/bin/cmd', in the way that `directory' is
accessed? I understand the former will cause a chdir()
which will invoke autofs_root_lookup(); in the latter case,
I don't know what goes on.

Noel Hunt
