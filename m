From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] Towards a Modern Autofs
Date: Tue, 06 Jan 2004 16:44:51 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FFB2C53.7050003@sun.com>
References: <3FFB12AD.6010000@sun.com> <3FFB223A.8000606@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============58421379551346919=="
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <3FFB223A.8000606@zytor.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============58421379551346919==
Content-type: multipart/signed;
 boundary=------------enigFA655EAB592CAF75661002DC;
 protocol="application/pgp-signature"; micalg=pgp-sha1

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA655EAB592CAF75661002DC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter,

H. Peter Anvin wrote:

>Mike Waychison wrote:
>  
>
>>The attached paper was written an attempt to design an automount system
>>with complete Solaris-style autofs functionality.  This includes
>>browsing, direct maps and lazy mounting of multimounts.  The paper can
>>also be found online at:
>>                                                                              
>>    
>>
>
>Sorry to sound like sour grapes, but this is a requirements document,
>not a proposed implementation.  
>
You surely read the whole thing, didn't you?

>Furthermore, as I have expressed before,
>I think your claim that expiry should be done in the VFS to be incorrect.
>  
>
Why?  You haven't convinced me that it should be elsewhere. 

>I think you're on the completely wrong track, because you're starting
>with the wrong problem.  The implementation needs to start with the VFS
>implementation and derive from that.
>  
>

In which sense?   Re-design it?

>Finally, throwing out the daemon is a huge step backwards.  Most of the
>problems with autofs v3 (and to a lesser extent v4) are due to the
>*lack* of state in userspace (the current daemon is mostly stateless);
>putting additional state in userspace would be a benefit in my experience.
>  
>
Bull.   Having a single process for each autofs filesystem is state in 
itself.   Eg:

- setup an auto_home map on /home
- mkdir /home2
- mount --bind /home /home2

The state that you manage with your automount processes themselves is 
now inconsistent with what the kernel has.  

>Pardon me for sounding harsh, but I'm seriously sick of the oft-repeated
>idiocy that effectively boils down to "the daemon can die and would lose
>its state, so let's put it all in the kernel."  A dead daemon is a
>painful recovery, admitted.  It is also a THIS SHOULD NOT HAPPEN
>condition.  
>

You've completely discarded the fact that a daemon breaks namespaces in 
your argument.

You somehow mistook the arguments I've presented and assume that we get 
rid of the daemon solely so that we eliminate state in userspace.  The 
point of getting rid of the daemon is that tying a single process to 
each mountpoint:

- breaks on mount --bind operations
- breaks on namespace clones

These _can_ be circumvented by using a single process daemon which 
catches _ALL_ automount requests from the kernel, however:

- There are NO facilities for changes namespaces, and there doesn't 
appear to be any plans to implement them.   This doesn't only affect the 
mount operations themselves, but also reading the /etc/auto_* maps in 
the different namespace.
- This limits a running system to _exactly_ one policy system for 
handling automount points.  Differing namespaces may have different 
automounter maps and even automounters themselves if they want to under 
the scheme I've outlined.

Also, the current implementation uses pathnames to do everything.  This 
breaks:

- mountpount binds in another way
- mountpoint moves

My goal here is to fix all of the mountpoint logic in automounting that 
relies on there being a single namespace. 

Now, going back to your argument of reliability and reconnectivity, yes, 
I agree that the daemon dying is something that _SHOULD NOT HAPPEN_.  
But it does in practice.  Getting rid of the daemon the way I've 
outlined simply eliminates that from ever happening as an added bonus.

>By cramming it into the kernel, you're in fact making the
>system less stable, not more, because the kernel being tainted with
>faulty code is a total system malfunction; a crashed userspace daemon is
>"merely" a messy cleanup.  In practice, the autofs daemon does not die
>unless a careless system administrator kills it.  It is a non-problem.
>  
>
"Faulty code"?    I haven't even presented you with code yet.  Nice.

Somehow, you got the impression that the system I've proposed would be 
more complex than what we have today, when in fact I believe it's a lot 
simpler.

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


--------------enigFA655EAB592CAF75661002DC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/+yxWdQs4kOxk3/MRAjKQAKCe3A7/yM0HUk/PVCUb/wLbFnBoTACfbrcb
woOVPXR3MD5ahERj6+zyzNg=
=rTHq
-----END PGP SIGNATURE-----

--------------enigFA655EAB592CAF75661002DC--


--===============58421379551346919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============58421379551346919==--

