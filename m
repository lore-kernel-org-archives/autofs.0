From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port usage
	problems
Date: Wed, 12 Jan 2005 20:05:42 -0500
Message-ID: <41E5C966.8050108@sun.com>
References: <200501130037.j0D0bNDj012842@jetcar.spd.analog.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <200501130037.j0D0bNDj012842@jetcar.spd.analog.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Meleedy wrote:
> Mike,
> 	I just recompiled my kernel with your xprt-sharing.patch.
> Although this did fix the port error problems, it did not fix
> the automounter problem.  So I think your patch should be incorporated
> into Redhat Enterprise 3 (2.4 kernel) because it appears to work.


There is a bit of hold-back from the NFS guys for getting this included
mainstream (what Red Hat does is their own business of course).

The reason does make sense.. there is a static number of request slots
available per transport session in the current rpc code.  Translated:
Only 16 io's are capable of being in flight for a given tcp stream with
this patch.

There is concern that this may impact performance numbers for NFS,
though I haven't yet seen hard numbers.  The good news is that there has
been extensive work done as well to allow for dynamic scaling of the
available request slots as part of the rpc transport switch code
happening at UMich.  I haven't had the chance to play with it though and
don't know if it is ready for prime time.  The likelyhood of it ever
making its way into RHEL3 is pretty low, but I can't speak for others.

> 
> I think the problem is that the automounter just cannot unmount
> the /net/aflac directory, and ends up trying to remount it instead,
> here are the log files after the port patch that Mike gave me:
> (this is during the reboot after cd'ing to /net/aflac/vol/vol2)
> 
> Jan 12 19:23:36 codered automount[5396]: can't shutdown: filesystem /net still 
> busy
> Jan 12 19:23:38 codered autofs: automount -USR2 succeeded
> Jan 12 19:23:41 codered automount[5396]: can't shutdown: filesystem /net still 
> busy
> ... those lines keep repeating until ....
> 
> Jan 12 19:24:08 codered automount[16092]: >> mount table full
> Jan 12 19:24:08 codered automount[16092]: mount(nfs): nfs: mount failure 
> aflac:/vol/vol3/cad_archive on /net/aflac/vol/vol3/cad_archive
> Jan 12 19:24:08 codered automount[16092]: >> mount table full
> Jan 12 19:24:08 codered automount[16092]: mount(nfs): nfs: mount failure 
> aflac:/vol/vol3/design on /net/aflac/vol/vol3/design
> ... those lines repeart for each subdirectory of the volumes ...
> 
> Jan 12 19:24:09 codered autofs: automount shutdown failed
> 
> As you can see, it keeps trying to unmount /net, and eventually
> fills up the mount table because it instead remounts it.  Before,
> when the port issue was a problem, it wouldn't get far enough to
> fill the mount table, but now it can (thanks Mike!)
> 
> -Dave
> 
> ________________________________________________________________________
> David Meleedy				Analog Devices, Inc.
> David.Meleedy@analog.com		Three Technology Way
> Phone: 781 461 3494			Norwood, MA  02062-9106  USA
> 
> 


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

iD8DBQFB5clmdQs4kOxk3/MRAo8LAJ9ud4FiaaXKEM9wdQQqyBxegiz8AQCeNvFF
+ZRiL2/tnbqd5BT78pFrAf4=
=aNy9
-----END PGP SIGNATURE-----
