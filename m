From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Mon, 12 Jan 2004 11:26:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <4002CAB6.3000800@sun.com>
References: <Pine.LNX.4.33.0401101325280.2403-100000@wombat.indigo.net.au>
 <40029C19.409@sun.com> <Pine.LNX.4.58.0401122356100.6362@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=------------enig4349031CA658B7AE40F974E7;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-reply-to: <Pine.LNX.4.58.0401122356100.6362@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
To: raven@themaw.net
Cc: Jim Carter <jimc@math.ucla.edu>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4349031CA658B7AE40F974E7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

raven@themaw.net wrote:

>On Mon, 12 Jan 2004, Mike Waychison wrote:
>
>  
>
>>>Transparency of an autofs filesystem (as I'm calling it) is the situation
>>>where, given a map
>>>
>>>/usr	/man1	server:/usr/man1
>>>	/man2	server:/usr/man2
>>>
>>>where the filesystem /usr contains, say a directory lib, that needs to be
>>>available while also seeing the automounted directories.
>>>
>>> 
>>>
>>>      
>>>
>>I see.  This requires direct mount triggers to do properly.  Trying to 
>>do it with some sort of passthrough to the underlying filesystem is a 
>>nightmare waiting to happen..
>>
>>    
>>
>
>So what are we saying here?
>
>We install triggers at /usr/man1 and /usr/man2.
>Then suppose the map had a nobrowse option.
>Does the trigger also take care of hiding man1 and man2?
>
>Is there some definition of these triggers?
>  
>
The example above is a direct map entry with no root offset.  The 
semantics are different than if it were an indirect map with browsing 
enable. 

I tested this out against other automount implementations and discovered 
that direct map entries with no root offsets should be broken down into 
several direct map entries with root offsets.. so:

/usr   /man1   server:/usr/man1   \
          /man2   server:/usr/man2

is the same as the two distinct entries:

/usr/man1   server:/usr/man1
/usr/man2   server:/usr/man2

Now that I think about it, the discussion in my proposal paper about 
multimounts with no root offsets probably isn't required.

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


--------------enig4349031CA658B7AE40F974E7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAAsq4dQs4kOxk3/MRAuO/AKCOZDrXEzeuiotXs7DKwPDbO7s7FQCggyQt
t90Go9Kqf9D+0f/Be52arLE=
=Fpm0
-----END PGP SIGNATURE-----

--------------enig4349031CA658B7AE40F974E7--
