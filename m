From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Automounting on /. deleting entire FS!
Date: Mon, 11 Oct 2004 13:52:24 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <416AC858.4010605@sun.com>
References: <20041011152938.GL21585@lego.fgm.com>
 <16746.43302.434588.743693@segfault.boston.redhat.com>
 <20041011160135.GM21585@lego.fgm.com>
 <16746.45101.876872.951336@segfault.boston.redhat.com>
 <20041011162927.GN21585@lego.fgm.com>
 <20041011170010.GI27189@debian-server.aei.mpg.de>
 <20041011171612.GO21585@lego.fgm.com>
 <20041011172446.GJ27189@debian-server.aei.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <20041011172446.GJ27189@debian-server.aei.mpg.de>
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
To: Steffen Grunewald <steffen.grunewald@aei.mpg.de>
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Steffen Grunewald wrote:
> On Mon, Oct 11, 2004 at 01:16:12PM -0400, Martin Fick wrote:

> 
>>>(BTW, it's a quite common trap, almost as efficient as chown -R xyz .*)
>>
>>  What is the common trap, automounting over slash?
> 
> 
> Yep. Did this ages ago, under SunOS (or was it already Solaris?)
> 

Heh, for another funny 'trap':   umount -l /

Don't do this unless you're ready for a reboot!


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

iD8DBQFBashXdQs4kOxk3/MRAiNYAJ9sObJ1deno7H7i/IvyKZAmPRCqDgCfQwBY
ibPElCHWeYDQ+Kzpg5/Qdx4=
=/Q3U
-----END PGP SIGNATURE-----
