From: Jeff Blaine <jblaine@kickflop.net>
Subject: Automounting of user dir failing for SSH publickey auth
Date: Fri, 24 Apr 2009 14:04:16 -0400
Message-ID: <49F1FF20.3010709@kickflop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

RHELv5 with kernel 2.6.18-53

SSH publickey authentication is failing for our users with
automounted home directories because the mount (/home/joe)
is expired and unmounted and sshd tries to find
/home/joe/.ssh/authorized_keys

If we 'cd /home/joe' every minute on the sshd host,
the mount is retained and publickey auth works every
time.

What are we doing wrong?  Surely this should work without
hackery to keep the share mounted.
