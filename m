From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] Towards a Modern Autofs
Date: Fri, 09 Jan 2004 16:31:19 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FFF1DA7.8060005@sun.com>
References: <3FFC96FE.9050002@zytor.com>
 <Pine.LNX.4.44.0401082050210.354-100000@donald.themaw.net>
 <20040108183135.GE30321@parcelfarce.linux.theplanet.co.uk>
 <3FFF03EA.4060603@sun.com> <3FFF07B2.70801@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============55739520587910185=="
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <3FFF07B2.70801@zytor.com>
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
Cc: autofs mailing list <autofs@linux.kernel.org>, viro@parcelfarce.linux.theplanet.co.uk, "Ogden, Aaron A." <aogden@unocal.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Ian Kent <raven@themaw.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============55739520587910185==
Content-type: multipart/signed;
 boundary=------------enig0BC603AFCD0DE3986BBF4C74;
 protocol="application/pgp-signature"; micalg=pgp-sha1

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0BC603AFCD0DE3986BBF4C74
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

>Mike Waychison wrote:
>  
>
>>>Special vfsmount mounted somewhere; has no superblock associated with it;
>>>attempt to step on it triggers event; normal result of that event is to
>>>get a normal mount on top of it, at which point usual chaining logics
>>>will make sure that we don't see the trap until it's uncovered by removal
>>>of covering filesystem.  Trap (and everything mounted on it, etc.) can
>>>be removed by normal lazy umount.
>>>
>>>Basically, it's a single-point analog of autofs done entirely in VFS.
>>>The job of automounter is to maintain the traps and react to events.
>>>
>>>      
>>>
>>Is there any clear advantage to doing this in the VFS other than saving
>>a superblock and a dentry/inode pair or two?
>>
>>I remember talking to you about this, and I seem to recall that these
>>mount traps would probably communicate using a struct file, so a
>>trap-user would somehow receive events about when the trap was set
>>off.   Will this communication model continue to work within a cloned
>>namespace?  What happens if the trap-client closes the file?
>>
>>    
>>
>
>The biggest issue is to ensure that the appropriate atomicity guarantees
>can be maintained.  In particular, it must be possible to umount the
>underlying filesystem and all mount traps on top of it atomically.
>Anything less will result in race conditions.
>
>	-hpa
>
>  
>
Unless I'm missing something, implementing this as a seperate filesystem 
type still has the appropriate atomicity guarantees as long as the VFS 
support complex expiry, whereby userspace would tag submounts as being 
part of the overall expiry for a base mountpoint.

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


--------------enig0BC603AFCD0DE3986BBF4C74
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//x2odQs4kOxk3/MRAmX7AJ48ewk0pgAvwtUvjNz6YMk4jVhAuACfRdBp
jfR4LzbYMcIDCHHqgolyhjQ=
=dirY
-----END PGP SIGNATURE-----

--------------enig0BC603AFCD0DE3986BBF4C74--


--===============55739520587910185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============55739520587910185==--

