From: Ian Kent <raven@themaw.net>
Subject: Re: autofsv5 enhancement - map names in /proc/mounts
Date: Tue, 14 Nov 2006 19:42:54 +0800
Message-ID: <1163504574.3297.34.camel@localhost>
References: <44AE7785.74E63D70@ggr.co.uk> <4554696C.5030400@ggr.co.uk>
	<45546B1F.5030306@ggr.co.uk> <1163213639.3113.15.camel@localhost>
	<45584448.2000102@ggr.co.uk> <1163432685.3016.21.camel@localhost>
	<4558A441.1030303@ggr.co.uk> <1163469607.3297.22.camel@localhost>
	<455993D9.4010003@ggr.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <455993D9.4010003@ggr.co.uk>
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
To: Gordon Lack <gml4410@ggr.co.uk>
Cc: autofs@linux.kernel.org

On Tue, 2006-11-14 at 10:00 +0000, Gordon Lack wrote:
> Ian Kent wrote:
> > 
> > I'd like to find a simple way to accommodate this while retaining the
> > multiple map functionality.
> 
>     Fine by me.  Bear in mind that the map-name (the bit I'm suggesting 
> should be added to /proc/mounts) will be different.  eg: from your 
> original example:
> 
>   /home	/etc/auto.server1.home
>   /home	/etc/auto.server2.home
> 
> So we'd end up with 2 lines in /proc/mounts:
> 
>   /etc/auto.server1.home /home autofs ....
>   /etc/auto.server2.home /home autofs ....

We would need to do something different as there will only ever be one
mount and so only one line in /proc/mounts.

Perhaps something like:

/etc/auto.server1.home,/etc/auto.server2.home	/home	autofs ....

and that could be further simplified by using nsswitch with "files" as a
source (you know they will be in /etc if not otherwise specified):

auto.server1.home,auto.server2.home	/home	autofs ....

> 
> (I think...although whether the patch I sent is sufficient to achieve 
> that I don't know)
> 

Well no, but it's fairly straight forward.

Ian
