From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: autofs reload
Date: Fri, 26 Mar 2004 11:58:41 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40646141.2040809@sun.com>
References: <E1B6tS8-0009vh-00.ia6432-inbox-ru@f10.mail.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <E1B6tS8-0009vh-00.ia6432-inbox-ru@f10.mail.ru>
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
| Hello,
|
| how to do correct autofs map reload?
| with older (3.9.99-4.0.0pre10) autofs updating nis maps works ok.
| for example changing in auto.home:
| host1:/export/home/user
| to
| host2:/export/home/user
| and doing ls /home/user leads to mounting new users home.


Ian responded to this a while back, see his answer at:
http://linux.kernel.org/pipermail/autofs/2004-February/000932.html

"That's right because, for file, NIS and LDAP maps, the daemon uses a
cache that is not aware of updates.

In 4.1.0 you can send a HUP signal to the daemon process controling the
map to ask it to update the map in similar fashion to running automount
on Solaris."

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

iD8DBQFAZGFAdQs4kOxk3/MRAiBrAKCFRbar4nWnTcRBPBDw9HlkCfifSACfdVEX
KeLa0I+Ei30gLF9gyQcL0Lc=
=FZyN
-----END PGP SIGNATURE-----
