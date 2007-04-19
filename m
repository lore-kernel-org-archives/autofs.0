From: Ian Kent <raven@themaw.net>
Subject: Re: autofs as a tfs replacement?
Date: Thu, 19 Apr 2007 21:38:07 +0800
Message-ID: <1176989888.3370.43.camel@raven.themaw.net>
References: <E1HeQOV-0004VV-00@mta2.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1HeQOV-0004VV-00@mta2.cl.cam.ac.uk>
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
To: Piete Brooks <Piete.Brooks--autofs@cl.cam.ac.uk>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 2007-04-19 at 07:45 +0100, Piete Brooks wrote:
> [ apologies if this is a repeat, but I didn't notice getting my copy before ]
> 
> Is there a simple way to get autofs to behave like tfs to get:
> 
> 	IF       /localdir/$key/ exists
> 	THEN use /localdir/$key/
> 	ELSE use server:/remotedir/$key/
> 
> I was hoping to use something like the multi-home mechanism which tried each 
> path in order until one worked.
> 
> I can set it up by hand using
> 
> 	d1	:/localdir/&
> 	d2	:/localdir/&
> 	*	-rw server:/remotedir/&
> 
> but that needs editing on each host as each /localdir/ is created.

Don't quite know what you mean by this?

> 
> I assume I can HACK it using a programme hook which looks to see if 
> /localdir/& exists, but it would be much cleaner to use the multi-home style 
> list. Is this possible?

Maybe:

*	-rw :/localdir/& server:/remotedir/&

I think that if /localdir/& doesn't exist the bind mount will fail after
which server:/remotedir/& should be tried.

Ian
