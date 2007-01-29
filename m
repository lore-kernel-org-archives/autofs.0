From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: Race condition in autofs 4.1.4
Date: Mon, 29 Jan 2007 16:33:50 +0100
Message-ID: <1170084830.2817.19.camel@sangay.TechFak.Uni-Bielefeld.DE>
References: <1169828641.32447.22.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1169831520.20795.1.camel@raven> <1169835048.6781.16.camel@localhost>
	<1169861439.3595.11.camel@raven.themaw.net>
	<1170081194.2817.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1170083944.2817.10.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TuFXFAtA1iRA+ocPGhLi"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1170083944.2817.10.camel@sangay.TechFak.Uni-Bielefeld.DE>
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


--=-TuFXFAtA1iRA+ocPGhLi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Montag, den 29.01.2007, 16:19 +0100 schrieb Lukas Kolbe:

> The system is now through more than 25000 mails, and hasn't hit the bug
> yet.
> When it finished delivering, I'll setup another mailbomb and stress it
> over the night, let's cross fingers that it works. I'll then file a bug
> with the debian util-linux package and attach the patch to it.
> Not close()ing the "we_created_lockfile" in unlock_mtab() seems like a
> bug to me, anyway ;)

Okay, the race hit again. Damnit!

Out of about 30000 mails, 8(!!!) didn't get delivered because:

Every 2.0s: ls -al /homes/ /nfs4homes | grep root                                                                                      Mon Jan 29 16:27:55 2007
drwxr-xr-x  7 root    root        0 2007-01-29 16:26 .
drwxr-xr-x 24 root    root     4096 2007-01-29 15:26 ..
dr-xr-xr-x  2 root    root        0 2007-01-29 16:11 musr352
dr-xr-xr-x  2 root    root        0 2007-01-29 16:17 musr847
drwxr-xr-x  8 root    root        0 2007-01-29 16:26 .
drwxr-xr-x 24 root    root     4096 2007-01-29 15:26 ..
dr-xr-xr-x  2 root    root        0 2007-01-29 16:17 musr847

These should look like
drwxr-xr-x  4 musr123 mailtest 4096 2007-01-17 16:59 musr123

And in /var/log/syslog appears again:
Jan 29 16:20:50 demon automount[29640]: mount(generic): warning: /homes/musr352 is already mounted

This was with debian's autofs 4.1.4-13, see 
ftp://ftp.de.debian.org/debian/pool/main/a/autofs/

And mount 2.12r-15.1, see ftp://ftp.de.debian.org/debian/pool/main/u/util-linux/
with the attached patch appliend, hence version number -15.1.

So, the patch made the problem appear way less, but it won't go away
completely. Ian, I guess that's what you suspected?

I'll try the test again overnight with an autofs timeout of 300.

-- 
Lukas


--=-TuFXFAtA1iRA+ocPGhLi
Content-Disposition: attachment; filename=70-mount-fstab-locking.dpatch
Content-Type: application/x-shellscript; name=70-mount-fstab-locking.dpatch
Content-Transfer-Encoding: 7bit

#! /bin/sh /usr/share/dpatch/dpatch-run
## 70-mount-fstab-locking.dpatch by  <linadm@smirnow.techfak.uni-bielefeld.de>
##
## All lines beginning with `## DP:' are a description of the patch.
## DP: hopefully fix lockin in fstab.c

@DPATCH@

--- util-linux-2.12r/mount/fstab.c      2004-12-21 19:09:24.000000000 +0000
+++ util-linux-2.12r-patched/mount/fstab.c      2007-01-29 14:17:05.000000000 +0000
@@ -417,6 +417,7 @@
 unlock_mtab (void) {
        if (we_created_lockfile) {
                unlink (MOUNTED_LOCK);
+               close(we_created_lockfile);
                we_created_lockfile = 0;
        }
 }
@@ -527,6 +528,7 @@
                                           MOUNTED_LOCK, strerror (errsv));
                                }
                                /* proceed anyway */
+                               we_created_lockfile = fd;
                        }
                } else {
                        static int tries = 0;
@@ -549,9 +551,9 @@
                                             MOUNTED_LOCK);
                                sleep(1);
                        }
+                       close(fd);
                }

-               close(fd);
        }
 }


--=-TuFXFAtA1iRA+ocPGhLi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=-TuFXFAtA1iRA+ocPGhLi--

