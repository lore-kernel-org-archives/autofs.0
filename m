From: Ian Kent <raven@themaw.net>
Subject: Re: autofs linux 3.8.13 and "Too many levels of symbolic links"
Date: Sat, 01 Feb 2014 09:47:55 +0800
Message-ID: <1391219275.2501.12.camel@perseus.fritz.box>
References: <52E92627.9050801@molgen.mpg.de>
		 <1391139080.2486.19.camel@perseus.fritz.box>
	 <1391145206.2486.25.camel@perseus.fritz.box> <52EB7694.20707@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=pjcxYudTerPy5q5GAVxvfW8KS9E=; b=kAfHsVO5ukczLtAa3FyyTZAFrJ+j
	89wF7LFXIMSx0Hsh6NRMFum7jXwZeX3qSH+Zlq8dunqojnVte5mJtwgZcDM6yjSn
	TAkwoEUqy5yzyujRDV/PBdhzkYbL0NO2KyE+vmn5oCQwMRolP61n46L981RhLI1t
	/BiSkruKwspCQRg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=pjcxYudTerPy5q5GAVxvfW
	8KS9E=; b=dveZrU/xSGyTzqUyx5JNwCRjiOh48Mt9MBRsGQ/aLVqUqaf0k5mYte
	6RzHAYdZbQ7s9PnasNehbDAoEVteNEiZfhAGhhqeL5k8gOo8bYh4rI5QOSzWLicK
	oOQsfN9l7oKu5jPhWDfFaVcjGhOeKsUwNNYlhnnviNVWXVHOaPt1w=
In-Reply-To: <52EB7694.20707@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: autofs <autofs@vger.kernel.org>

On Fri, 2014-01-31 at 11:10 +0100, Donald Buczek wrote:
> 
> Hello, Ian,
> 
> you said, "how DCACHE_MOUNTED would not be cleared on umount", so you 
> are thinking about the unmount path. I asked my users and in two cases 
> (including the one described in this thread) they think, it happened the 
> very first time they accessed the path after boot. This suggest, the 
> problem might appear on the mount path.
> 
> Also, both were on workstations (single user!) and they both used a 
> shell ( "cd /failing/path" and "do_something > /failing/path/bla" ) , so 
> collisions (other threads accessing the same path at the same time) are 
> unlikely.
> 
> We don't have any hints which would suggests, that there might have been 
> a problem with the fileserver or network involved (which would imply a 
> bug in the "mount failure" path)

Thanks for all this, I appreciate it.

snip ...

> I've checked the mounts as you asked ( 
> http://owww.molgen.mpg.de/~buczek/autofs-demo/typescript_3.l ) the 
> dentry 0xffff88016a31c440 identified in the previous sessions (and still 
> there) is not in any mnt_mountpoint

LOL, it was a long shot and now I know for sure, good.

> 
> How can DCACHE_MOUNTED be set when there was no mount?
> The problem appears rarely and (until now) randomly. Locking failure?
> 
> Okay, I've managed to get the nvidia bullshit drivers to work on linux 
> 3.13.1 , so I'm going to reboot this workstation (with the three 
> failures) to the latest kernel now with DEBUG set in the autofs4 directory.

It's probably a good idea for you to get to some later kernel anyway.
See this (not my doing) in 3.8 fs/namei.c

/*
 * Clear dentry's mounted state if it has no remaining mounts.
 * vfsmount_lock must be held for write.
 */
static void dentry_reset_mounted(struct dentry *dentry)
{
        unsigned u;

        for (u = 0; u < HASH_SIZE; u++) {
                struct mount *p;

                list_for_each_entry(p, &mount_hashtable[u], mnt_hash) {
                        if (p->mnt_mountpoint == dentry)
                                return;
                }
        }
        spin_lock(&dentry->d_lock);
        dentry->d_flags &= ~DCACHE_MOUNTED;
        spin_unlock(&dentry->d_lock);
}

Which means all dentries in the system need to be scanned before
DCACHE_MOUNTED is cleared. Now that's not a problem for a smallish
number of mounts but can be a problem for larger numbers of mounts or if
there's a large number of dentries in the system.

Don't remember exactly when Al Viro fixed it but it's easy to check.

> 
> Perhaps we shouldn't waste to much time analyzing code which is 
> obsoleted already. I'll surly tell you, when the problem is seen again 
> with 8.13.

Thanks again.
Ian


