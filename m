From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] Towards a Modern Autofs
Date: Fri, 09 Jan 2004 14:41:30 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FFF03EA.4060603@sun.com>
References: <3FFC96FE.9050002@zytor.com>
 <Pine.LNX.4.44.0401082050210.354-100000@donald.themaw.net>
 <20040108183135.GE30321@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============087403064359012017=="
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <20040108183135.GE30321@parcelfarce.linux.theplanet.co.uk>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: autofs mailing list <autofs@linux.kernel.org>, "Ogden, Aaron A." <aogden@unocal.com>, "H. Peter Anvin" <hpa@zytor.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Ian Kent <raven@themaw.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============087403064359012017==
Content-type: multipart/signed;
 boundary=------------enigDF8BFFCC985004A828D633B9;
 protocol="application/pgp-signature"; micalg=pgp-sha1

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDF8BFFCC985004A828D633B9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Thu, Jan 08, 2004 at 08:52:31PM +0800, Ian Kent wrote:
>  
>
>>On Wed, 7 Jan 2004, H. Peter Anvin wrote:
>>
>>    
>>
>>>These are the mount traps Al Viro has been architecting.
>>>
>>>      
>>>
>>Please tell me about these.
>>
>>I have`nt seen any discussion on the implementation.
>>
>>Just a few sentences ....
>>    
>>
>
>Special vfsmount mounted somewhere; has no superblock associated with it;
>attempt to step on it triggers event; normal result of that event is to
>get a normal mount on top of it, at which point usual chaining logics
>will make sure that we don't see the trap until it's uncovered by removal
>of covering filesystem.  Trap (and everything mounted on it, etc.) can
>be removed by normal lazy umount.
>
>Basically, it's a single-point analog of autofs done entirely in VFS.
>The job of automounter is to maintain the traps and react to events.
>
>  
>
Is there any clear advantage to doing this in the VFS other than saving 
a superblock and a dentry/inode pair or two?

I remember talking to you about this, and I seem to recall that these 
mount traps would probably communicate using a struct file, so a 
trap-user would somehow receive events about when the trap was set 
off.   Will this communication model continue to work within a cloned 
namespace?  What happens if the trap-client closes the file?

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


--------------enigDF8BFFCC985004A828D633B9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//wPtdQs4kOxk3/MRAiUvAJ9AdoamY4cnkTfTF4eRq00Ue+6/ygCfcauv
aeslSGMIzLiEiGNx/3Pb0FY=
=Hp/r
-----END PGP SIGNATURE-----

--------------enigDF8BFFCC985004A828D633B9--


--===============087403064359012017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============087403064359012017==--

