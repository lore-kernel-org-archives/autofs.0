From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: making the mountpoints visible all the time (fwd)
Date: Thu, 20 Nov 2003 17:43:05 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FBD6DA9.70204@zytor.com>
References: <Pine.LNX.4.33.0311210848040.32325-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0311210848040.32325-100000@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

Ian Kent wrote:
> 
> To fit in with the existing framework I would need to require the entire
> map returned for a NULL key.
> 

That's correct.

> 
>>And of course autofs needs to deal with the consequences of the map
>>changing underneath it.
> 
> I normally reread the map and try again on lookup failure. There is the
> HUP signal to do a manual map reread.
> 

A better option is probably to update periodically.  You still need to
be able to handle query of a mount point that you don't know about
(might have appeared anew) or a mount point you thought exist not being
found.

	-hpa
