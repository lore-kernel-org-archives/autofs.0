From: Ian Kent <raven@themaw.net>
Subject: Re: [VFS-RFC] autofs4 and bind, rbind and move mount requests
Date: Wed, 25 May 2005 09:22:18 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0505250920230.25715@wombat.indigo.net.au>
References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
	<Pine.LNX.4.61.0505231847470.6229@xena.cft.ca.us>
	<Pine.LNX.4.62.0505242325331.8219@donald.themaw.net>
	<E1Dae8H-0004bV-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1Dae8H-0004bV-00@dorka.pomaz.szeredi.hu>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: autofs@linux.kernel.org

On Tue, 24 May 2005, Miklos Szeredi wrote:

> 
> > So your in favour of a bind mount behaving in a sense like a chroot.
> > 
> > This I think I can do that but that's not how bind mount behaviour is 
> > defined in mount(8). Hence the discussion.
> > 
> > What I would have trouble doing is maintaining two distinct trees 
> > of mount points which is in line with the definition.
> > 
> > And there's also the question of recursive bind mounts????
> 
> You can always say in the manual: don't do that, or expect the
> unexpected!
> 
> > Oh yes Miklos, we haven't even started talking about submounts, each with 
> > its own map! Sorry, I'm sure you have enough to do already but I thought 
> > you might like to follow the discussion a little further.
> 
> OK.  Why are submounts special?

Simply because they increase the complexity of the issue.
A new mount, a new daemon, new set of possible mounts completly seperate 
from the parent.

Ian
