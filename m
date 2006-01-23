From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: some questions about the configuration
Date: Mon, 23 Jan 2006 16:10:24 +0100
Message-ID: <43D4F1E0.2060201@inria.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

I recently started to clean-up the mandriva autofs package a bit, and I
have some questions about the default configuration handling.

First, it seems autofs-ldap-auto-master, which is installed in
/usr/lib/autofs, and auto.{net,smb}, which are installed in /etc, have
exactly the same purpose: to automatically produce a list of available
mount points from a remote host. If I am right, why are them installed
and named differently ? Apart the fact that the first one is native
code, whereas the others are shell scripts, they could as well get
installed as /usr/lib/autofs/auto.{ldap,smb,net}

Second, it's not clear why ldap and nis use are triggered from the
content of /etc/nsswitch.conf, while smb and net (simple rpcinfo
listing) use are triggered from content of /etc/auto.master. Shouldn't
all those syntax be available from both locations?

--=20
Adultery is the application of democracy to love
		-- H.L. Mencken on Murphy n=B02
