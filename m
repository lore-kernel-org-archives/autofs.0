From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Thu, 08 Jan 2004 14:41:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3FFDB280.90504@sun.com>
References: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net>
 <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net>
 <3FFD9498.6030905@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=------------enigAA93FE809B62A8103D1642D5;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-reply-to: <3FFD9498.6030905@zytor.com>
List-Id: <autofs.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ian Kent <raven@themaw.net>, Mike Waychison <Michael.Waychison@Sun.COM>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAA93FE809B62A8103D1642D5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:
> Ian Kent wrote:
> 
>>
>> If wildcard map entries are not in autofs v3 then Jeremy implemented this
>> in v4.
>>
> 
> v3 has had wildcard map entries and substitutions for a very, very, very 
> long time... it was a v2 feature, in fact.
> 
>> And yes the host map is basically a program map and that's all. Worse, as
>> pointed out in the paper it mounts everything under it. This is a source
>> of stress for mount and umount. I have put in a fair bit of time on ugly
>> hacks to work around this. This same problem is also evident in startup
>> and shutdown for master maps with a good number of entries (~50 or more).
>> A consequence of the current multiple daemon approach.
> 
> 
> This is why one wants to implement a mount tree with "direct mount 
> pads"; which also means keeping some state in the daemon.
> 
> For example, let's say one has a mount tree like:
> 
> /foo        server1:/export/foo \
> /foo/bar    server1:/export/bar \
> /bar        server2:/export/bar
> 
> ... then you actually have four diffenent filesystems involved: first, 
> some kind of "scaffolding" (this can be part of the autofs filesystem 
> itself or a ramfs) that hold the "foo" and "bar" directories, and then 
> foo, foo/bar, and bar.
> 
> Consider the following implementation: when one encounters the above, 
> the daemon stashes this away as an already-encountered map entry (in 
> case the map entries change, we don't want to be inconsistent), creates 
> a ramfs for the scaffolding, creates the "foo" and "bar" subdirectories 
> and mount-traps "foo" and "bar".  Then it releases userspace.  When it 
> encounters an access on "foo", it gets invoked again, looks it up in its 
> "partial mounts" state, then mounts "foo" and mount-traps "foo/bar", 
> then releases userspace.
> 
> In many ways this returns to the simplicity of the autofs v3 design 
> where the atomicity constraints where guaranteed by the VFS itself, *as 
> long as* mount traps can be atomically destroyed with umounting the 
> underlying filesystem.
> 

Great!

This is exactly what I found when looking into the situation.  However, 
namespaces still break automounting unless you can rid yourself of the 
daemon.  Move events into call_usermodehelper calls in current's 
namespace and maintain what little state you need as a set of tokens.


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

--------------enigAA93FE809B62A8103D1642D5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//bKEdQs4kOxk3/MRAgI3AJkB83e2YDhKTcCi/d7/QJXWC3ScNwCfQkHx
q94YjVZTGng0sHH7zMYXS30=
=mJpZ
-----END PGP SIGNATURE-----

--------------enigAA93FE809B62A8103D1642D5--
