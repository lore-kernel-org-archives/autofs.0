From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Fri, 09 Jan 2004 17:00:23 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FFF2477.9060909@sun.com>
References: <Pine.LNX.4.44.0401031051350.4413-100000@raven.themaw.net>
 <Pine.LNX.4.53.0401091118050.9335@simba.math.ucla.edu>
 <3FFF1CCF.2070904@sun.com>
 <Pine.LNX.4.53.0401091330490.9335@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============61256762441623303=="
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.53.0401091330490.9335@simba.math.ucla.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============61256762441623303==
Content-type: multipart/signed;
 boundary=------------enigA99325A66258AEF78F655AD4;
 protocol="application/pgp-signature"; micalg=pgp-sha1

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA99325A66258AEF78F655AD4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jim Carter wrote:

>On Fri, 9 Jan 2004, Mike Waychison wrote:
>
>  
>
>>Jim Carter wrote:
>>    
>>
>>>No, I meant that when the sys_stat method fills in the mode field of
>>>the returning stat structure, it would be reported as 555 for a busy
>>>filesystem, or 755 if it looks idle and dismountable.  The mode field as
>>>seen by the VFS layer can stay at 755.  This would be when statting
>>>autofs's directory inode, not whatever is mounted on it.
>>>      
>>>
>
>  
>
>>This hijacking of the st_mode is just that, hijacking.  You'd be
>>changing the mode of the directory on the NFS filesystem..  This
>>wouldn't work well in the VFS when it tries to check permissions, but it
>>also wouldn't work for more than one NFS client accessing the same
>>filehandle.
>>    
>>
>
>There are 2 inodes here: the mount point (owned by autofs) and what's
>mounted on it.  We mustn't monkey with the mountee's data, of course.  I'm
>talking about statting the mount point itself.  You can't do that by name,
>but in a prior discussion we were talking about opening the mount point
>before the mount, and later doing fstat on the file descriptor.  HPA
>mentioned providing a readlink method and doing lstat on the mount point by
>name, which would intercept the path walk before the mountee was noticed.
>
>So the caller gets the mode of the mount point, which autofs can create or
>interpret any way it wants, rather than the mountee's data.
>
>  
>
Ok.  Then the kernel would need to periodically make these checks..   It 
could work, but I see it as yet another communication kludge.

>>>I would really like it if, when autofs decided to forcibly unmount, it
>>>could kill the using processes, as in "fuser -k -m /net/host/mountpoint".
>>>Actually this is a general issue for unmount(8), not specific to autofs.
>>>But one wonders whether fuser is going to run wild...
>>>      
>>>
>
>  
>
>>Like HPA already mentioned, this is bad.  I don't even think you could
>>reliably detect this.
>>    
>>
>
>Agreed, you wonder if the right processes are going to be picked.  But...
>"Ask for the moon; they might give it to you."  In the present case it
>should be possible to stick the fuser execution into the autofs shutdown
>script -- it already is aware that unmounts haven't finished, and it
>probably knows or can find out which filesystems are involved.
>
>  
>
This probably isn't best placed in the initscript.  The automount daemon 
should instead have a timeout setup for unmounting these filesystems.  
If the unmount hangs for more than x seconds, move on to the next one.   
Let init take care of killing off processes if they haven't died in time 
for shutdown. 

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


--------------enigA99325A66258AEF78F655AD4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//yR6dQs4kOxk3/MRAo3CAJwP2eqU2kSsF/paTiM0iJCpk3J70ACgizCa
TD1huqIuINAv+FjtyNMDM9o=
=SvTi
-----END PGP SIGNATURE-----

--------------enigA99325A66258AEF78F655AD4--


--===============61256762441623303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============61256762441623303==--

