From: Ian Kent <raven@themaw.net>
Subject: Re: direct map shut down?
Date: Sat, 21 Feb 2004 15:42:02 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0402211534050.4697@raven.themaw.net>
References: <1077211015.19371.32.camel@brilong-lnx2.cisco.com> 
 <1077211301.19371.34.camel@brilong-lnx2.cisco.com> 
 <Pine.LNX.4.58.0402202058120.4573@raven.themaw.net>
 <1077284694.21595.54.camel@brilong-lnx2.cisco.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1077284694.21595.54.camel@brilong-lnx2.cisco.com>
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
To: Brian Long <brilong@cisco.com>
Cc: autofs@linux.kernel.org

On Fri, 20 Feb 2004, Brian Long wrote:

> 
> > 4.03 is an old version of autofs4. Current is 4.04.
> > Strange to see it in RHEL. I thought they didn't want to include it.
> 
> The didn't include it in their stock kernel.  They put all their
> "unsupported" stuff into an RPM called kernel-unsupported.  I ripped
> autofs4.o out of it and loaded it on my system for testing.  I was
> hoping direct maps in your later versions might support the multiple
> mounts I need.  I'll look into using the multimount functionality.

Thinking about it, you could use submounts if you are willing to local 
file maps (or you use linux only global maps). This is likely how I'll 
implement it in the daemon (internally that is).

I'll put an example map together and send it of to you when I get a bit of 
time.

> 
> Do you have plans to get multiple mounts working with direct maps in the
> near future?  Will this involve kernel-module changes or just user-land
> tool changes?

I've been aware of this limitation for a long time and have put much 
thought into how I can do it. It's quite hard but I do have an idea of 
how I will do it. But near future is always a big question mark as I work 
on autofs in my spare time.

Ian
