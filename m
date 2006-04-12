From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: kernel panic when accessing local filesystems on NFS
	server
Date: Wed, 12 Apr 2006 14:20:30 -0400
Message-ID: <x49vete1wr5.fsf@segfault.boston.redhat.com>
References: <443CF70F.90001@inria.fr>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <443CF70F.90001@inria.fr> (Guillaume Rousse's message of "Wed,
	12 Apr 2006 14:48:15 +0200")
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] kernel panic when accessing local filesystems on NFS server; Guillaume Rousse <Guillaume.Rousse@inria.fr> adds:

Guillaume.Rousse> When autofs is not activated, ls /home/graves/ftp works
Guillaume.Rousse> OK. As soon as autofs is activated, ls /home/graves/ftp
Guillaume.Rousse> triggers immediate kernel panics (can't handle kernel
Guillaume.Rousse> paging request). This is happening on a mandriva 10.2,
Guillaume.Rousse> running kernel 2.6.11-13mdk, with autofs 4.1.4. It is
Guillaume.Rousse> also a recent problem, which didn't occured earlier.

Guillaume.Rousse> It seems I have to hide client maps to servers exporting
Guillaume.Rousse> them. Which is quite difficult as I use LDAP precisely to
Guillaume.Rousse> propagate a centralised configuration. But even if my
Guillaume.Rousse> configuration is wrong, autofs ought to be a little more
Guillaume.Rousse> robust here.

Autofs is probably attempting a recursive bind mount.  This problem was
fixed, upgrade your kernel.

	http://lkml.org/lkml/2005/6/4/11

-Jeff
