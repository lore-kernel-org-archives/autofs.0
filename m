From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Fri, 09 Jan 2004 16:27:43 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FFF1CCF.2070904@sun.com>
References: <Pine.LNX.4.44.0401031051350.4413-100000@raven.themaw.net>
 <Pine.LNX.4.53.0401091118050.9335@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============58051623154556498=="
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.53.0401091118050.9335@simba.math.ucla.edu>
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
--===============58051623154556498==
Content-type: multipart/signed;
 boundary=------------enig09B295A7BC080ABA21F2A78E;
 protocol="application/pgp-signature"; micalg=pgp-sha1

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig09B295A7BC080ABA21F2A78E
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jim Carter wrote:

>On Sat, 3 Jan 2004, Ian Kent wrote:
>  
>
>>On Fri, 2 Jan 2004, Jim Carter wrote:
>>    
>>
>>>Right, expire.c :: autofs4_expire() bypasses a mount point if its last_used
>>>field is too recent, and then it checks is_tree_busy().  Oh, look, a kludge
>>>that could be added, how wonderful!  Assuming that it's feasible to get
>>>module-provided data into the inode data returned from sys_stat or
>>>sys_fstat, a mode bit could be set to indicate busyness, e.g. user write
>>>implies not busy.
>>>      
>>>
>>A user write implies an open file. The expire routine must identify this
>>dentry as busy or it's a bug that needs to be fixed.
>>    
>>
>
>No, I meant that when the sys_stat method fills in the mode field of
>the returning stat structure, it would be reported as 555 for a busy
>filesystem, or 755 if it looks idle and dismountable.  The mode field as
>seen by the VFS layer can stay at 755.  This would be when statting
>autofs's directory inode, not whatever is mounted on it.
>
>  
>
This hijacking of the st_mode is just that, hijacking.  You'd be 
changing the mode of the directory on the NFS filesystem..  This 
wouldn't work well in the VFS when it tries to check permissions, but it 
also wouldn't work for more than one NFS client accessing the same 
filehandle.

>Is it really true that the VFS layer doesn't maintain use counts for
>directories where you can find them easily?
>
>  
>
Use counts for directories?  The of a file has no real consistent 
corelation with which directory that file belongs.

>>>So the key task is to bulldoze aside the wreckage so a new instance of the
>>>revitalized NFS server can be mounted.  Killing the moribund processes and
>>>forcibly dismounting the destroyed filesystem instance are important so as
>>>to recover resources, but the client can continue to function for quite a
>>>long time even if that's not done; the only totally vital action is to be
>>>able to remount, and that can possibly be done by renaming, or by
>>>remounting the wreckage elsewhere, deferring the actual dismount.
>>>      
>>>
>>I'll have to think about this for a while. The rename idea might cause all
>>sorts of problems.
>>    
>>
>
>I can imagine.  Maybe a -move remount?  Can you even do this when the
>mounted FS is busy?  Well...
>
>mkdir mtpt1 ; mkdir mtpt2
>mount -t nfs hollyfs:/m1 mtpt1
>cd mtpt1
>sleep 3600 &		(PID is 2486)
>cd ..
>umount mtpt1		(device is busy -- correct)
>mount --move mtpt1 mtpt2	(works -- yay!)
>ls -l /proc/2486/cwd	(says: /proc/2486/cwd -> /tmp/root.jimc/mtpt2/)
>grep mtpt /proc/mounts	(says: hollyfs:/m1 /tmp/root.jimc/mtpt2 nfs...)
>grep mtpt /etc/mtab	(says: hollyfs:/m1 /tmp/root.jimc/mtpt1 nfs...
>			/tmp/root.jimc/mtpt1 /tmp/root.jimc/mtpt2 none rw 0 0
>kill 2486
>umount mtpt2		(works -- correct)
>grep mtpt /proc/mounts	(says: nothing)
>grep mtpt /etc/mtab	(says: hollyfs:/m1 /tmp/root.jimc/mtpt1, hiss, boo)
>
>So you can do a move mount on a busy filesystem; the only downside is that
>/etc/mtab has a stale entry in it -- obviously a bug, not an essential
>behavior.
>
>  
>
Yup, it's a bug, however now that you can mount two filesystems on top 
of each other, there really is no reliable way to know which entry in 
/etc/mtab has moved.  Eg:

# mkdir /foo
# mount -o ro host:/path /foo
# mount -o rw host:/path /foo
# cat /etc/mtab
(two lines for /foo are printed)
# mkdir /bar
# mount --move /foo /bar

Which entry in /etc/mtab is changed from /foo to /bar?  Unless you can 
make steadfast rules on entry ordering, you can't reliably decide which 
entry has changed.

Even worse, /etc/mtab is broken when using multiple namespaces.

>>A kill -9 on the blocked process needs further investigation. I'm not sure
>>what the situation is there (probably not good).
>>    
>>
>
>I would really like it if, when autofs decided to forcibly unmount, it
>could kill the using processes, as in "fuser -k -m /net/host/mountpoint".
>Actually this is a general issue for unmount(8), not specific to autofs.
>But one wonders whether fuser is going to run wild...
>
>  
>
Like HPA already mentioned, this is bad.  I don't even think you could 
reliably detect this.

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


--------------enig09B295A7BC080ABA21F2A78E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//xzRdQs4kOxk3/MRAgntAJ9drXy62P26J/9eBF6B3Fq0jw/MhACfReb5
7EaITiFxLn5wKGbCPPmafKg=
=tIYO
-----END PGP SIGNATURE-----

--------------enig09B295A7BC080ABA21F2A78E--


--===============58051623154556498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============58051623154556498==--

