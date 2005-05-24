From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [VFS-RFC] autofs4 and bind, rbind and move mount requests
Date: Tue, 24 May 2005 20:28:01 +0200
Message-ID: <E1Dae8H-0004bV-00@dorka.pomaz.szeredi.hu>
References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
	<Pine.LNX.4.61.0505231847470.6229@xena.cft.ca.us>
	<Pine.LNX.4.62.0505242325331.8219@donald.themaw.net>
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.62.0505242325331.8219@donald.themaw.net>
	(raven@themaw.net)
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org


> So your in favour of a bind mount behaving in a sense like a chroot.
> 
> This I think I can do that but that's not how bind mount behaviour is 
> defined in mount(8). Hence the discussion.
> 
> What I would have trouble doing is maintaining two distinct trees 
> of mount points which is in line with the definition.
> 
> And there's also the question of recursive bind mounts????

You can always say in the manual: don't do that, or expect the
unexpected!

> Oh yes Miklos, we haven't even started talking about submounts, each with 
> its own map! Sorry, I'm sure you have enough to do already but I thought 
> you might like to follow the discussion a little further.

OK.  Why are submounts special?

Miklos
