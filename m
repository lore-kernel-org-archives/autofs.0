From: "Gordon Lack" <gml4410@ggr.co.uk>
Subject: Re: -hosts and -null enabling for autofs v4.1.x
Date: Fri, 14 Jul 2006 12:33:14 +0100
Message-ID: <44B780FA.DC42CB24@ggr.co.uk>
References: <44AE7785.74E63D70@ggr.co.uk>
	<x49u05laae9.fsf@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Jeff Moyer wrote:
>
> gml4410>    For -null, it just adds the mountpoint location to the list of
> gml4410> knownmaps, but doesn't do anything else.
> 
> This isn't exactly right.  It should "nullify" the next occurrence of the
> given mount point, and then go away.
 
   That isn't how automount maps are supposed to work (at least not Sun
ones, according to how I read the documentation).  Only the *first*
occurrence of a mountpoint is supposed to be used - that is meant to
override *all* following occurences.


>  Consider a map like this:
> 
> /home -null
> +auto.master
> /home /etc/auto.home
> 
> Let's assume that +auto.master reads the master map from nis, and the nis
> master map defines /home to point to some nis map.  The above would ignore
> the /home entry in the nis master, and allow us to replace it with our own.

   If you want to replace an entry in NIS you add your entry *before*
loading the NIS maps.  So to set your own /home to override the NIS one
you use:

 /home /etc/auto.home
 +auto.master

   The -null map is so that you may wipeout *all* occurrences of a
mountpoint that you would otherwise have.  At least that's how I've
always read it.  In that respect it is no different to something like:

 /amp auto.map1
 /amp auto.map2
 /amp auto.map3

where I would expect to see auto.map1 used on /amp, since once there is
a map on a mountpount it won't be overridden.

Also note - we're talking about Sun-style automounts here.  Anyone with
OSF1 would (might) know they do everything backwards (the *last* map
wins...)
