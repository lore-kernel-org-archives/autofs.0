From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Replicated hosts in autofs v4.
Date: Tue, 12 Oct 2004 02:06:37 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <416B9E9D.6010108@sun.com>
References: <bf092570041010091873f86c2f@mail.gmail.com>
 <200410110053.40587.vda@port.imtp.ilyichevsk.odessa.ua>
 <16746.42133.679569.866410@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0410120935520.32308@wombat.indigo.net.au>
 <Pine.LNX.4.58.0410112111140.6187@xena.cft.ca.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.58.0410112111140.6187@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jim Carter wrote:
> On Tue, 12 Oct 2004, Ian Kent wrote:
> 
>>On Mon, 11 Oct 2004, Jeff Moyer wrote:
>>
>>> Server proximity takes priority in the  selection  process.
>>
>>Mike, can we define "proximity" and "same network segment" as used in the 
>>Solaris automounter please (if that's possible).
> 
> 
> The desired behavior (and I think this is what our Sun boxes actually do)  
> is that if the client has an interface such that (clientIP & netmask) ==
> (serverIP & netmask) (using the client's same netmask for both), then that
> server is preferred because the traffic goes direct, not through a router.  
> The client might have multiple interfaces.
> 

I believe this is the right interpretation of the 'weight override' bit
that Jeff posted from the Solaris automount(1m) manpage.

However, I believe that algorithm uses some sort of traceroute/rpcping
to figure out distances and weights are used to prioritize given equal
distances.  I'll ask around to see what the actual method used is. (a
tcpdump of this may prove useful ;)

> If there are multiple servers and one is down, another can be tried after a
> brief timeout.  But what really interests me is hot failover:  you already
> mounted server "A", which dies.  The automounter is magically aware of
> this, and mounts server "B".  Can of worms: Processes with open files
> (readonly of course) in the dead filesystem, you would like to transfer
> them transparently to presumably identical files from the other server. 
> In a map row with multiple servers, all share the same mount point, so how
> do you dispose of the corpse so you can mount the other server on the 
> same-named mount point?  None of this will be easy.
> 

Note, this 'hot failover' functionality is only prescribed to work when
the filesystem is mounted _read only_.  I believe this is handled by the
NFS subsystem proper as the stateless nature of NFS2/3 would make this
feasible for the read-only case.  Again, I'll ask around to see how this
is handled and will post back when I get an answer.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBa56ddQs4kOxk3/MRApIMAJ47NUyh7yoZucN8YKXvtu4AnR9JTQCgl7Ny
99axGIQugUaU3fBuggDb0iQ=
=0gDc
-----END PGP SIGNATURE-----
