From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: autofs no_local_binds option (nfs <-> bind mounts)
Date: Tue, 13 Jan 2004 15:58:43 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40045C03.7020405@sun.com>
References: <200401131958.i0DJwlV0001078000@anw.zk3.dec.com>
 <40044F2A.9080305@zytor.com> <200401132023.49657.autofs@dylan.me.uk>
 <4004544C.7030904@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============58097944038240756=="
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <4004544C.7030904@zytor.com>
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
Cc: autofs@linux.kernel.org, Eric Werme USG <werme@alpha.zk3.dec.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============58097944038240756==
Content-type: multipart/signed;
 boundary=------------enig9199E617F590C39C0F2FF355;
 protocol="application/pgp-signature"; micalg=pgp-sha1

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9199E617F590C39C0F2FF355
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

>Dylan wrote:
>  
>
>>On Tuesday 13 January 2004 20:03 pm, H. Peter Anvin wrote:
>>
>>
>>    
>>
>>>However, this doesn't address the issue of the client being *the same
>>>system*, in which case you can't just move the IP address away from
>>>it, since local == remote; you can no longer send packets to the
>>>server and get a response back.  You can do it if you can get the
>>>client and the server sides to bind to *different* IP addresses, in
>>>which case the current autofs behaviour will correctly see them as
>>>being separate and mount NFS.
>>>      
>>>
>>Would binding an alias address to the interface be sufficient?
>>
>>    
>>
>
>No, you have to force the local port to not be bound to the same
>address.  I think this can be done with iptables rules, but I'm not
>sure... I'm not a networking wizard.
>
>  
>
I know you can do this using chbind from the vserver toolset and kernel 
patch.

http://www.13thfloor.at/vserver/s_release/v1.23/

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


--------------enig9199E617F590C39C0F2FF355
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFABFwGdQs4kOxk3/MRAtbNAKCNi94tossdCAsNiENLZ4TbDtEYfwCdGxrk
O1uVzyNZampEMzHOz4hWV3o=
=6jXp
-----END PGP SIGNATURE-----

--------------enig9199E617F590C39C0F2FF355--


--===============58097944038240756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============58097944038240756==--

