From: Ian Kent <raven@themaw.net>
Subject: Re: making the mountpoints visible all the time (fwd)
Date: Wed, 19 Nov 2003 16:13:12 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0311191612420.24336-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>

On Sun, 16 Nov 2003, H. Peter Anvin wrote:

> Ian Kent wrote:
> >
> > But how do you know what the keys are?
> >
> > In order to make mount points visible you need to know what they are. The
> > definition of a program map is that it produces map entries as output
> > given an input key.
> >
>
> You need a new operation on a map -- enumerate.  Most, but not all map
> types support it.
>
> In the case of a program map I would suggest implementing enumeration by
> passing no argument and expecting the enumerated list back.
>

That sounds good a good idea for inclusion in 4.1.1 (I have quite a list
already).

Move the decision on what the map contains to the program map implementer.
That would be fairly straight forward to implement given that I have a
placeholder function in each map module.

Ian
