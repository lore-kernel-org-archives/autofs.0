From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] Towards a Modern Autofs
Date: Fri, 09 Jan 2004 15:52:41 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FFF1499.7030508@sun.com>
References: <Pine.LNX.4.33.0401100223130.21972-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70508637203649327=="
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.33.0401100223130.21972-100000@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============70508637203649327==
Content-type: multipart/signed;
 boundary=------------enig059AD2C113BEFBAFBB7D0536;
 protocol="application/pgp-signature"; micalg=pgp-sha1

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig059AD2C113BEFBAFBB7D0536
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ian Kent wrote:

>On Thu, 8 Jan 2004, H. Peter Anvin wrote:
>
>  
>
>>Ian Kent wrote:
>>    
>>
>>>If wildcard map entries are not in autofs v3 then Jeremy implemented this
>>>in v4.
>>>
>>>      
>>>
>>v3 has had wildcard map entries and substitutions for a very, very, very
>>long time... it was a v2 feature, in fact.
>>
>>    
>>
>>>And yes the host map is basically a program map and that's all. Worse, as
>>>pointed out in the paper it mounts everything under it. This is a source
>>>of stress for mount and umount. I have put in a fair bit of time on ugly
>>>hacks to work around this. This same problem is also evident in startup
>>>and shutdown for master maps with a good number of entries (~50 or more).
>>>A consequence of the current multiple daemon approach.
>>>      
>>>
>>This is why one wants to implement a mount tree with "direct mount
>>pads"; which also means keeping some state in the daemon.
>>
>>For example, let's say one has a mount tree like:
>>
>>/foo		server1:/export/foo \
>>/foo/bar	server1:/export/bar \
>>/bar		server2:/export/bar
>>
>>... then you actually have four diffenent filesystems involved: first,
>>some kind of "scaffolding" (this can be part of the autofs filesystem
>>itself or a ramfs) that hold the "foo" and "bar" directories, and then
>>foo, foo/bar, and bar.
>>
>>Consider the following implementation: when one encounters the above,
>>the daemon stashes this away as an already-encountered map entry (in
>>case the map entries change, we don't want to be inconsistent), creates
>>a ramfs for the scaffolding, creates the "foo" and "bar" subdirectories
>>and mount-traps "foo" and "bar".  Then it releases userspace.  When it
>>encounters an access on "foo", it gets invoked again, looks it up in its
>>"partial mounts" state, then mounts "foo" and mount-traps "foo/bar",
>>then releases userspace.
>>
>>    
>>
>
>Umm. The cross filesystem problem again.
>
>This may sound a little silly but it may be able to be done using
>stackable filesystem methods (aka. Zadok et. al.). I'm thinking of an
>autofs filesystem stacked on a host filesystem. The dentrys corresponding
>to mount points marked in some way and the mount occuring under it, on top
>of the host filesystem. Yes I know it sounds ugly but maybe it's not.
>Maybe it's actually quite simple. I can't give an opinion yet as I'm still
>thinking it through and haven't done any feasibility. However, this
>approach would lend itself to providing autofs filesystem transparency. A
>requirement as yet not discussed.
>
>Ian
>
>  
>
Doing stackable filesystems is still an area of OS research.  It turns 
out to be a very hard problem to solve (if it's possible at all).   
Although there are systems in the wild that appear to work, they are 
usually sub-optimal because there remains alot of issues such as 
maintaining coherent caches, as well as just staying coherent given that 
one filesystem may be directly accessible while also accessed from 
another overlayed filesystem.

Not really something you'd want to waste alot of time on unless your 
looking for a phd thesis. ;)

-- 
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


--------------enig059AD2C113BEFBAFBB7D0536
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//xSbdQs4kOxk3/MRAjgxAJ98Qyqkx2dfsuDUx5qk1OzVDjaMmwCgnWLT
9uwicVWBCVgsTaIEZ1CmNGE=
=DYaO
-----END PGP SIGNATURE-----

--------------enig059AD2C113BEFBAFBB7D0536--


--===============70508637203649327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============70508637203649327==--

