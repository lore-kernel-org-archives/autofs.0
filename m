From: "Amodiovalerio [Hypo] Verde" <valerio.verde@moby.it>
Subject: autofs and smb shares
Date: Wed, 31 Mar 2004 21:01:21 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <003001c41752$8e510cd0$657ba8c0@mobylines.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Class: urn:content-classes:message
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
To: autofs@linux.kernel.org

Hi,

I have a problem with autofs ( well I think is autofs related ).

Using fedora, kernel 2.6.4, autofs 4.1.1.

Set up a smb share and it works quite fine mounting and unmounting it.

The problem is that autofs seems not be able to umount the share when the
share became unavailable ( like stopping sharing the directory ).

When I'm in the share, and share goes away, autofs won't umount it, also if
timeout is expired.

(with previos version of autofs, I could see in message log all the
timeouts, so I assume it will try to umount the share).

If I do an ls it just give me a "ls: testdir: Invalid slot" until I manually
umount the share. ( I'm able to umount the share manually without forcing
and without any error )

When I umount the share manually autofs will continue to works regular, so
if I try to go in the share dir, and the share is not available,
it just give me a "-bash: cd: testdir: No such file or directory", until the
share became available and it mount.

Could someone help me to understand this behaviour ?


Amodiovalerio [Hypo] Verde
