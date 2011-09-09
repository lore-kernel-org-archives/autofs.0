From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] vfs: automount should ignore LOOKUP_FOLLOW
Date: Fri, 09 Sep 2011 11:37:44 +0800
Message-ID: <1315539464.3952.45.camel@perseus.themaw.net>
References: <87hb4q9b3r.fsf@tucsk.pomaz.szeredi.hu>
	 <1315281208.3210.26.camel@perseus.themaw.net>
	 <87mxeixfaq.fsf@tucsk.pomaz.szeredi.hu>
	 <1315319903.3210.51.camel@perseus.themaw.net>
	 <87ipp5y912.fsf@tucsk.pomaz.szeredi.hu>
	 <1315485406.3476.9.camel@perseus.themaw.net>
	 <87bouv17dc.fsf@tucsk.pomaz.szeredi.hu>
	 <CA+55aFy3VN2Y-oadFUMdCaBVQtPT9Ae3fDQCw5vHfA6UvH8GiA@mail.gmail.com>
	 <20110908195043.GV2203@ZenIV.linux.org.uk>
	 <CA+55aFzfXOi2xk1JVnTTzQPzoNH+iQkhtpT6cVEz+D7si8MAfw@mail.gmail.com>
	 <20110908215425.GW2203@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:from:to:cc:in-reply-to:references
	:content-type:date:message-id:mime-version
	:content-transfer-encoding; s=smtpout; bh=1DCpgEr5L83oJAIcseLhFi
	XrMlw=; b=NgjJpEhJpx7MXRMzbDhZOPhQsZBaNcfnqlv0B+UbMtPGYRbO2ZYnf2
	cx45O8ApftstULv6le4jxBSXMCwWmXy88N0MjCBMwtJqmJcmZbT4fUdXGbb3Uezb
	5772pMQJaxLC7kPG2sK+mds3I88S7+hk+yI2vwliBatlA2KRki1fQ=
In-Reply-To: <20110908215425.GW2203@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Leonardo Chiquitto <leonardo.lists@gmail.com>, autofs@linux.kernel.org

On Thu, 2011-09-08 at 22:54 +0100, Al Viro wrote:
> On Thu, Sep 08, 2011 at 01:19:49PM -0700, Linus Torvalds wrote:
> 
> > >> I'm inclined to apply the patch as a regression fix, but I'll let this
> > >> thread try to convince me for another day..
> > >
> > > IIRC, that matches traditional SunOS behaviour and it actually does make
> > > sense; you want wildcard expansion and ls -l to be doable even when there's
> > > a stuck NFS server. ?IOW, non-triggering lstat(2) is a matter of usability...
> > 
> > non-triggering lstat() isn't the issue, afaik. We never trigger on lstat.
> > 
> > nontriggering *stat()* is the issue. We didn't *use* to trigger on
> > stat() either. Now in 2.6.38+ we do.
> 
> Yes.  Again, IIRC that's what SunOS implementation had been doing all along;
> I think the reason was that stat()+open()+fstat() getting different results
> for stat and fstat would spook quite a few programs, but I could be easily
> wrong on that.

Yes, that the sort of problem that we see.

For example, find(1) has had problems with this sort of inconsistency
with before and after comparisons it makes as it walks the directory
tree.

Ian


