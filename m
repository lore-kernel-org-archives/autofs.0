From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.0.0 beta6 beta release
Date: Thu, 29 Jun 2006 19:16:59 +0800
Message-ID: <200606291116.k5TBGxwr030546@raven.themaw.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org
Cc: linux-fsdevel@vger.kernel.org

Hi all,

Another beta.

Please find a little time to check this out.

autofs
======

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.0.0_beta6.tar.[gz|bz2]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.0.0_beta6.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.0.0_beta6.tar.gz

See the INSTALL file for information about configure options and
kernel requirements.

Here are the entries from the CHANGELOG which outline the updates:

29/6/2006 autofs-5.0.0_beta6
----------------------------
- lookup_init cleanup and fix missed memory leak.
- use nis map order to check if update is needed.
- fix couple of memory leaks in lookup_yp.c.
- fix pasre error in replicated server module.
- correct spelling error in default config.
- fix default auth config not being installed.
- change LDAP query method as my test db was incorrect.
- change ldap defaults code to handle missing auth config.
- fix mistake in parsing old style LDAP specs.
- update LDAP so that new query methos also works for old
  syntax.
- allow global macro defines to override system macros.
- cleanup defaults_read_config.
- add rfc2307-bis example map configurations.
- change mode of of config file install to 644.
- update kernel patches.
- fix don't unbind on error return from get_query_dn.
- update RedHat autofs default config.

Ian
