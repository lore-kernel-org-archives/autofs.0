From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: exporting autofs managed directory using NFS
Date: Fri, 25 Jun 2004 12:09:12 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40DC4E28.6030606@sun.com>
References: <40DADD60.5090201@intraperson.com>
 <16603.10543.236802.870131@segfault.boston.redhat.com>
 <40DB7F5F.5070500@intraperson.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <40DB7F5F.5070500@intraperson.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: ramana <ramana@intraperson.com>
Cc: autofs@linux.kernel.org, hpa@zytor.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ramana wrote:
> Jeff Moyer wrote:
>
>> ==> Regarding [autofs] exporting autofs managed directory using NFS;
>> ramana <ramana@intraperson.com> adds:
>>
>> ramana> We are facing problems where /home is managed by autofs ( in
>> ramana> Autodir ) but this directory is to to be exported using NFS.
>>
>> ramana> Exactly reverse of what autofs supposed to do -- lol
>>
>> ramana> When tried to mount nfs exported home some where else,
>> Persmission
>> ramana> denied error is reported by nfs server.
>>
>> Are you saying you want to reexport an nfs mounted filesystem?  I don't
>> believe that is supported.
>>
>> -Jeff
>>
>> .
>>
>>
>>
>
>
> No. Autodir do mount local directories only on autofs mounted fs.
>
> In simple terms, exporting this special case autofs mounted dir using nfs.
>
> Please check http://www.intraperson.com/autodir.html
>

The kernel nfs server doesn't export across mountpoints by default.  You
may try using the nohide option, but it has limitations (like the fact
that it must be a single host export).

I suspect that the kernel nfsd may have issues trying to export an
autofs imported fs, so I'd try the userspace nfs server.

What I don't understand is why don't you run an automounter on the other
host and have nis maps that point to the respective home dir locations?

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3E4mdQs4kOxk3/MRAiSNAKCaWriyC3sk1DVkSoEpEb3bF2AxXwCcDafZ
l+XMvtrgyEY8OjM87jH6EWM=
=H3Lq
-----END PGP SIGNATURE-----
