From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/2] autofs: fix two related bugs with lookup + expired
 yp maps
Date: Thu, 05 May 2016 18:21:46 +0800
Message-ID: <1462443706.3011.15.camel@themaw.net>
References: <1462406612-2354-1-git-send-email-jeffm@suse.com>
	 <1462437320.3011.7.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=C5lEyHriGA8kKgBC1VPIeN5B5cs=; b=vFdtFa
	Fry/+ake2lL5/Gr779Xi8H+iWKXjMOfeLUAuq2fqy4Ghtdn5pTBg1sCVU0JVGrPw
	vbI3cPUSKbmqgf6p8NZrBFr2C/nt3xir8SSGAcPgVWodY/x1p/fUpoCN1abRhW1Q
	fMXbj8Qt6bZaRMEhYRQCZixaCGjFAt1MzWn7k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=C5lEyHriGA8kKgB
	C1VPIeN5B5cs=; b=lVqf1OlJLYlAxk/TAdpGqF348G1IZ5VqJUPKtDA+1m/qZRe
	YaVJBvcGZKf7rEUenGDOkOKAJHwBoa6O+nnEMUy9b1LKnYRc6c9SEdXLjufRqXJo
	8V9WISBmotGOj+50LfyIJQvafYdkdHrTOJ7ftOjMSH31244aZeUWhjecns64=
In-Reply-To: <1462437320.3011.7.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: jeffm@suse.com, autofs@vger.kernel.org

On Thu, 2016-05-05 at 16:35 +0800, Ian Kent wrote:
> On Wed, 2016-05-04 at 20:03 -0400, jeffm@suse.com wrote:
> > From: Jeff Mahoney <jeffm@suse.com>
> > 
> > Hi Ian -
> > 
> > We recently encountered an issue where a client would all of a sudden
> > start returning ELOOP for anything involving crossing an autofs mount.
> > We tracked it down to two bugs, one which obscured the other.  The
> > first
> > is that we were not properly updating the map age for yp maps when we
> > retry
> > the lookup with dots instead of underscores.  The second is that it is
> > possible under several situations to return success when there was a
> > failure in lookup_nss_mount.  In this particular case, it was the only
> > map in the list and since the age wasn't update, it was skipped.  Then
> > we exit the while loop with ret == 0, ultimately returning success to
> > the caller.  Autofs would tell the kernel it succeeded, the kernel
> > would
> > retry the lookup, and we'd loop until we hit the kernel loop limit
> > (40).
> > 
> > These two patches fix each of the issues.
> 
> OK, that sounds good.
> 
> I'll have a look at the code to make sure I understand what's going on
> before adding these to the list of patches I have.
> 
> That list is getting a bit large now so I'll likely be committing them
> soonish but I can't say yet when I'll release 5.1.2.
> 
> Up until now I thought that the source of the ELOOP returns that some
> people have seen were due to incorrect returns of in kernel mounted
> checks where mounts were present in other namespaces.
> 
> My most recent attempt at resolving that had a positive response from a
> tester here on the list but another tester experienced file system
> corruption. I'm totally at mystified by this so I'm a bit stuck at the
> moment. 

When importing these I've made a couple of changes I hope you will be ok with.
The content of the patches remains the same (assuming I have no other questions
when I properly review them).

Due to my convention of trying to always have the patch title the same as the
patch name I had to change the first patch.

I changed the patch name (and title with "-" changed to " ") to:
autofs-5.1.1-fix-yp-map-age-not-updated-during-map-lookup.patch

The description remains the same and I think still conveys the intent of the
change.

I changed only autofs: to autofs-5.1.1 in the second patch.

Finally I assume your ok with me adding your "Signed-off-by:" to both patches,
along with mine.

> 
> > 
> > Thanks,
> > 
> > -Jeff
> > 
> > Jeff Mahoney (2):
> >   autofs: fix yp map age not updated in s/_/./g case
> >   autofs: properly handle errors in lookup_nss_mount
> > 
> >  daemon/lookup.c     |  5 ++++-
> >  modules/lookup_yp.c | 17 ++++++++---------
> >  2 files changed, 12 insertions(+), 10 deletions(-)
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
