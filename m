From: Nick Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 09/18] autofs4: Add d_manage() dentry operation [ver #4]
Date: Sat, 15 Jan 2011 01:37:43 +1100
Message-ID: <AANLkTin7GaJq6RuQdWkzY7XnH12-=8Gebr24Pyy+fWG+@mail.gmail.com>
References: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
	<20110113215448.19406.58770.stgit@warthog.procyon.org.uk>
	<1295013099.2794.6.camel@perseus>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OXRk6SSysPdwOg2heIIp4KEWmhxC4TC3FtNONgyLZr4=;
        b=Cosi2WwW9AAM1WPyiu7xcuhdJCESTscqc1uS2m2BcsQR2X6z0bR/gyEcK0uCDa6vrT
         YNPdt2xamjcuY9w77IFUXg7zwMz/GYXc9RPKJa4byYzCr4YA//FDtOcbxwNGALTY9m3o
         wYSrh+1ci9R1XxxGEtQOcFUds9Lx9lODAD/is=
In-Reply-To: <1295013099.2794.6.camel@perseus>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Sat, Jan 15, 2011 at 12:51 AM, Ian Kent <raven@themaw.net> wrote:
> On Thu, 2011-01-13 at 21:54 +0000, David Howells wrote:
>> From: Ian Kent <raven@themaw.net>
>> + =A0 =A0 //spin_lock(&dcache_lock); =A0/////////////// JUST DELETE =
THIS LOCK?
>> + =A0 =A0 if (!d_mountpoint(dentry) && list_empty(&dentry->d_subdirs=
)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&dentry->d_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(dentry->d_flags & DCACHE_MANAGE_TRAN=
SIT) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(dentry->d_flags & DCACHE_NEED_=
AUTOMOUNT))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __managed_dentry_set_trans=
it(path->dentry);
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&dentry->d_lock);
>> + =A0 =A0 }
>> + =A0 =A0 //spin_unlock(&dcache_lock);
>
> In this case I think the dcache_lock needs to be deleted and the d_lo=
ck
> moved out of the if to protect the d_subdirs access.

Right. If you follow the vfs-scale-working git branch series of
patches leading up to dcache_lock removal, it gives a pretty
good template of how to convert old dcache_lock using code
to new locking.

Although you can also just look at locking in fs/dcache.c and
convert code from that.

Any time you are dealing with just a *single* dentry, then
->d_lock would be enough to replace dcache_lock (it
actually protects more than dcache_lock alone did).
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
