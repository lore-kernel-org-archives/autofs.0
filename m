From: Ian Kent <raven@themaw.net>
Subject: Re: [VFS-RFC] autofs4 and bind,
	rbind and move mount requests
Date: Tue, 24 May 2005 09:06:07 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0505240846410.26293@wombat.indigo.net.au>
References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
	<E1DaERw-0002cC-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.62.0505232339250.3469@donald.themaw.net>
	<E1DaG04-0002hk-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1DaG04-0002hk-00@dorka.pomaz.szeredi.hu>
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
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org, linux-kernel@vger.kernel.org

On Mon, 23 May 2005, Miklos Szeredi wrote:

> > Perhaps not in this case.
> 
> Maybe I'm misunderstanding.
> 
> Are you talking about an automounted filesystem, or the autofs
> filesystem itself.

I'm talking about the autofs filesystem (actually the autofs4 module).

> 
> With the later I can well imagine that you have problems with bind and
> move.

yep.

I'm not really concerned about whether bind and move mounts work or not. I 
just need to establish whether these should be supported and if so, how 
they should work so I can resolve the problem. Personally, I would be 
happy to say these types of mounts are not supported by autofs if I could 
veto the requests.

atm I can easily panic the kernel. As I said, it would be fairly easy to 
fail silently but ....

There's not much in it but see:
http://bugme.osdl.org/show_bug.cgi?id=4589

Sorry that my initial post was unclear and perhaps incomplete but mostly 
people are not that familiar with automounting and often they don't really 
want to know about it. I guess they have their own priorities.

Thanks for your interest.
Ian
