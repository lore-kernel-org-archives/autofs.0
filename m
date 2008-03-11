From: Ian Kent <raven@themaw.net>
Subject: Re: More directories?
Date: Tue, 11 Mar 2008 10:12:58 +0900
Message-ID: <1205197978.2955.5.camel@raven.themaw.net>
References: <47D4445E.10100@bononline.nl>
	<1205114970.3025.19.camel@raven.themaw.net>
	<47D4DFFC.8010705@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47D4DFFC.8010705@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org


On Mon, 2008-03-10 at 08:15 +0100, Stef Bon wrote:
> Ian Kent wrote:
> > Its totally dependent on what is returned from the script.
> > The example script, auto.smb, just returns an entry with a multi-mount
> > offset for each share. If a more complex multi-mount is returned that
> > should work fine. The old auto.hosts would often return a more complex
> > multi-mount entry as NFS exports are often deeper than a single level.
> >
> > Ian
> >
> >   
> Ok, That's clear. I know that's it's the script which should return it.
> 
> What I want to know is, is it possible to use mountpoint's like:
> 
> ../<USER>/server/share/<mounted smb share>
> 
> A multimount with the first key the <USER>.

Return everything else but the key as usual.
Format like:

[-fstype=<type>,<options] [[/] [localtion] \
	/<dir> location \
	/<dir> location ....

The leading "/" is required and the root mount "/" is optional.
It's been a while since I played with this but I think the offsets of
the multi-mount need to be in depth order.

Ian
