From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: autofs reload
Date: Fri, 26 Mar 2004 12:34:23 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4064699F.80301@sun.com>
References: <E1B6v6s-000EvK-00.ia6432-inbox-ru@f13.mail.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <E1B6v6s-000EvK-00.ia6432-inbox-ru@f13.mail.ru>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; format="flowed"; charset="us-ascii"
To: Peter Lojkin <ia6432@inbox.ru>
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Peter Lojkin wrote:
| On Fri, 26 Mar 2004 at 11:58:41 -0500, Mike Waychison wrote:
|
|
|>Ian responded to this a while back, see his answer at:
|>http://linux.kernel.org/pipermail/autofs/2004-February/000932.html
|
| thanks! missed this one...
|
|
|>"That's right because, for file, NIS and LDAP maps, the daemon uses a
|>cache that is not aware of updates.
|>
|>In 4.1.0 you can send a HUP signal to the daemon process controling the
|>map to ask it to update the map in similar fashion to running automount
|>on Solaris."
|
| then maybe we should do this on autofs reload instead of restarting
| daemons?
|

Sure, however doing so will not pick up any changes to the master map :(

- --
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
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAZGmedQs4kOxk3/MRAtaPAJ900FWk/VIKySRwiwtPHyEV/17ejACghZ61
SiCjqCHy86w/ntoX2sztgbg=
=HkPf
-----END PGP SIGNATURE-----
