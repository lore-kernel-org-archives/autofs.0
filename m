From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: nested automounts: bind and nfs
Date: Tue, 02 Oct 2007 12:25:53 +0200
Message-ID: <1191320754.27255.7.camel@localhost>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1191300830.26331.24.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1191300830.26331.24.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


Am Dienstag, den 02.10.2007, 12:53 +0800 schrieb Ian Kent:
> On Mon, 2007-10-01 at 16:08 +0200, Lukas Kolbe wrote:
> > Hi!
> > 
> > I'm having the problem that was described last year on this list:
> > http://osdir.com/ml/linux.kernel.autofs/2006-08/msg00040.html
> > 
> > Given the following mount map:
> > 


> Can you post a debug log of this failure please.
> Instructions to get what we need can be found at
> http://people.redhat.com/jmoyer.

Okay:

/etc/auto.master:
/vol    /etc/auto_vol_linx_new

autofs5 version: 5.0.2-4, that is the same as in debian experimental
plus all patches from the kernel.org directory applied.

auto_vol_linx_new contains:

eclipse-3.1 \
   /bin          -rw,nosuid,grpid          fileserver:/volumes/vol1/eclipse-3.1/bin.linx86
eclipse \
   /bin          -rw,nosuid,grpid          :/vol/eclipse-3.1/bin

Which should bind-mount /vol/eclipse/bin from /vol/eclipse-3.1/bin, and
nfs-mount /vol/eclipse-3.1/bin from the fileserver.

lkolbe@lahn cgrep /etc/nsswitch.conf 
passwd:         compat
group:          compat
shadow:         compat
hosts:          files dns mdns
networks:       files
protocols:      db files
services:       db files
ethers:         db files
rpc:            db files
automount:      files nis
netgroup:       nis

lkolbe@lahn cgrep /etc/default/autofs
MASTER_MAP_NAME="/etc/auto.master"
TIMEOUT=300
BROWSE_MODE="no"
LOGGING="debug"

Trying to reproduce it:

lkolbe@lahn ls -la /vol/eclipse/bin/
ls: /vol/eclipse/bin/: No such file or directory

lkolbe@lahn ls -la /vol/eclipse-3.1/bin/
total 0
drwxrwsr-x 2 root eclipse 96 2007-09-12 14:34 .
dr-xr-xr-x 7 root root     0 2007-10-02 12:16 ..
-rw-r--r-- 1 root eclipse  0 2007-09-12 14:34 foo

lkolbe@lahn ls -la /vol/eclipse/bin/
ls: /vol/eclipse/bin/: No such file or directory

And a few seconds later:

lkolbe@lahn ls -la /vol/eclipse/bin/
total 0
drwxrwsr-x 2 root eclipse 96 2007-09-12 14:34 .
dr-xr-xr-x 8 root root     0 2007-10-02 12:16 ..
-rw-r--r-- 1 root eclipse  0 2007-09-12 14:34 foo

daemon.log comes in the next mail.

> Ian

-- 
Lukas
