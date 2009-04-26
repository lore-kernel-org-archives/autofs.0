From: Thomas Connell <tconnell@modwest.com>
Subject: Re: Mountpoint string corruption in autofs5.0.3-3?
Date: Sun, 26 Apr 2009 10:36:28 -0600
Message-ID: <49F48D8C.3060803@modwest.com>
References: <49F0F494.4030008@modwest.com>
	<20090426034752.GA3084@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090426034752.GA3084@zeus.themaw.net>
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

Ian Kent wrote:
> Is this string corruption really present in the log?

It is.

> If this really is in the log so you will need to narrow down where this
> corruption is happening.

I gave it a shot; I am largely a complete C novice, but:

Following the debugging from the nfs module, the log shows:
Apr 26 09:49:30 web6 automount[3920]: mount_mount: mount(bind): root=/domains/f/federalhousingtaxcredit.com name=/ 
what=/www/vhosts/f/federalhousingtaxcredit.com, fstype=bind, options=

Which all looks right to me.

Since I could see in the logs that fullpath was garbled, I was wondering if maybe alloca wasn't getting the right length.  I did 
a bit of trial and error, and it seems consistent that fullpaths of 33 or over become garbled.

So, in mount_bind.c, I added:

debug(ap->logopt, MODPREFIX "name_len=%d", name_len);

right after

int i, rlen;

and

debug(ap->logopt, MODPREFIX "name_len=%d rlen=%d", name_len, rlen);

right after

rlen = strlen(root);


The logs show:

Apr 26 10:05:46 web6 automount[7353]: mount_mount: mount(bind): name_len=0
Apr 26 10:05:46 web6 automount[7353]: mount_mount: mount(bind): name_len=0 rlen=0

which looks wrong to me! (even though it happens the same for the domains that worked before, and those that did not.)

I would expect name_len == 1 so that the program enters this block:
    /* Root offset of multi-mount */
    if (*name == '/' && name_len == 1) {
       rlen = strlen(root);
       name_len = 0;

instead of, right after it:

    } else if (*name == '/')
       rlen = 0;


If I set alloca to an arbitrarily high number, the previously garbled mounts mount correctly, without corruption.  It seems like 
for this style of mount, name_len should be 1, not 0.


By the way, the automount map looks like:
# federalhousingtaxcredit.com, domains, jails, Mounts, modwest.com
dn: cn=federalhousingtaxcredit.com,ou=domains,ou=jails,ou=Mounts,dc=modwest,dc=com
objectClass: automount
cn: federalhousingtaxcredit.com
automountInformation: / :/www/vhosts/f/federalhousingtaxcredit.com /.renv :/mnt/jail


For now, I guess I can just waste some memory by setting alloca() arbitrarily high, but that doesn't seem the correct solution.

I hope this reconnaissance was helpful.

Thanks,

Thomas Connell
