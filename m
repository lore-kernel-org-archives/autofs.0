From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [patch] umount loopback filessystems on autofs stop
Date: Fri, 03 Sep 2004 08:30:34 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <413863EA.8080602@sun.com>
References: <11395.1094160050@ichips.intel.com> <4137D77E.9080703@sun.com>
 <41383357.2000305@moving-picture.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <41383357.2000305@moving-picture.com>
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
To: James Pearson <james-p@moving-picture.com>
Cc: autofs@linux.kernel.org, raven@themaw.net, jmoss@ichips.intel.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

James Pearson wrote:
> Mike Waychison wrote:
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Joseph V Moss wrote:
>>
>>> Using /proc/mounts could be an issue for anyone trying to use this
>>
>>
>> with a kernel
>>
>>> that truncates /proc/mounts.
>>>
>>
>>
>> Which kernel truncates /proc/mounts?
>>
>> Any recent kernel uses the seq_file interface which guarantees that
>> nothing gets truncated.  I have a system up and running that works fine
>> with about 2500 mounts.
>
>
>
> seq_file support for /proc/mounts was introduced with 2.4.19
>

Heh, which is only over two years old :)

Seriously, if your kernel doesn't do this right, the problem doesn't lie
with Jeff's initscript patch: please consider upgrading.

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

iD8DBQFBOGPpdQs4kOxk3/MRAkGlAJkBLHG2rYJZS9IbPn/qLP2mPAitPwCfcVv3
NegYJQX2jtqQwNV9STncXnY=
=k5GF
-----END PGP SIGNATURE-----
