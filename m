From: =?iso-8859-1?q?J=F6rg=20Fichter?= <Joerg.Fichter@gmx.de>
Subject: automount
Date: Mon, 2 Feb 2004 20:49:10 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200402022049.10239.Joerg.Fichter@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

Dear Sirs,

I've installed the automount system on my PC. Different user works on thi=
s=20
terminal! So I modified the auto.master file like this:

/misc	/etc/auto.misc		user, exec, uid=3D700, gid=3D500

But all user who were logged in and automount a filesystem, will always h=
ave=20
the username like 700 and the groupname like 500 on this mount point.

How can I modify auto.master and auto.misc to get the right username and=20
groupname for each logged user?

Thanks for your help.

Sincerely

J=F6rg Fichter
