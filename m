From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Proposal for map refresh logic
Date: Tue, 25 May 2004 12:28:12 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40B3741C.9010205@sun.com>
References: <Pine.LNX.4.58.0405212143160.1592@donald.themaw.net>
 <Pine.LNX.4.58.0405210855001.28570@simba.math.ucla.edu>
 <Pine.LNX.4.58.0405221120001.1524@donald.themaw.net>
 <Pine.LNX.4.58.0405231647030.4243@xena.cft.ca.us>
 <Pine.LNX.4.58.0405250859330.21143@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.58.0405250859330.21143@wombat.indigo.net.au>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ian Kent wrote:
> On Sun, 23 May 2004, Jim Carter wrote:
>
>
>>>So you are saying we only set a flag when the tests above indicate a map
>>>is out of date. But how do we know when user space expects to see an
>>>up-to-date map other than a changed map entry? So to use a TTL will give
>>>us the oppertunity to check for an outdated map entry. Again only for
>>>ghosted maps.
>>
>>The issue I'm worrying about is, suppose all cache hits until now,
that had
>>timed out and were rechecked from the map, turned out to be correct.  But
>>suppose there is a map row which we haven't seen yet, either because we
>>just never read it, or because the map was enumerated some time ago
but has
>>been added to since then?  If the user reads the whole directory you have
>>to ignore the cache and re-read the NIS map every time (unless you rely on
>>the NIS order number, not generalizable) (OK to just stat a file map).
>>But then, if you can't distinguish "read whole directory" from "hunt for
>>one file in directory", you end up re-reading the entire map when you
don't
>>want to.
>
>
> I'm concerned about that issue as well. I'm still not sure how to deal
> with that.
>
> One thing to be aware of is that the kernel module and the daemon don't
> really know much about each other. So the cache is, for the purpose of
> this issue, either not available or is available much to late to be able
> to change the directory listing. Essentially, the directories are created
> in the filesystem by the daemon after reading the map and at some later
> time the kernel uses that alone to list the directory contents.
>
> I think that, for this, modifiying the kernel module is an absolute last
> resort as the place for handling this context information is the daemon.
>
>
>>Forgive my meager kernel knowledge, but even if opendir is the same for
>>both uses, isn't there a separate object method implementing readdir,
>>versus looking up a file by name?  Readdir should bypass the cache,
reading
>>the NIS or LDAP map directly, while lookup should and does use the cache.
>
>
> The kernel never sees the cache.

This is further complicated as the kernel may call the readdir operation
once per directory/map entry.

> The filesystem itself must be kept up to
> date. Creating or removing directories during a readdir operation will
> end in tears without a doubt.

- ->readdir itself is serialized on the parent inode's i_sem, as are all
real_lookups (the call that makes the ->lookup callback).

>
> But the real worry is the frequency with which this happens (as I
> mentioned above).
>
> If we could just come up with a workable heuristic for map refresh we
> would be OK.
>

What is wrong with a cache of map keys in kernelspace? (Other than
modifying the kernel module being a last resort)



- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAs3QbdQs4kOxk3/MRAnefAJoDUROWmiwg7dM9i2/QLKavgCbtmACfU/o5
TuXkvVUMVUMClKYbRsH+hA4=
=0ugm
-----END PGP SIGNATURE-----
