From: Ian Kent <raven@themaw.net>
Subject: Re: automounting issues: cannot open parse module dc=de
Date: Sun, 14 Jun 2009 13:44:31 +0800
Message-ID: <4A348E3F.4070608@themaw.net>
References: <4A325A8B.3050503@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A325A8B.3050503@cs.tu-berlin.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: aaron <aaron@cs.tu-berlin.de>
Cc: autofs@linux.kernel.org

aaron wrote:
> Hi everyone at autofs discussion list,
> 
> I'm having some serious problems with the automounter daemon on my
> system. I'm using gentoo and everything was fine (besides some regular
> autofs crashes) using autofs-5.0.4-r2 (that's autofs-5.0.4 and all
> patches up to autofs-5.0.4-fix-quoted-mess.patch). After upgrading to
> autofs-5.0.4-r3 (that's autofs-5.0.4 and all patches up to
> autofs-5.0.4-dont-umount-existing-direct-mount-on-reread.patch)
> automounting suddenly failed to work for me. The situation hasn't
> changed with autofs-5.0.4-r4 (that's autofs-5.0.4 and all patches up to
> autofs-5.0.4-use-srv-query-for-domain-dn.patch)
> 
> Here are the errors from /var/log/messages (same happens when I try to
> automount /company/home):
> 
> Jun 11 21:29:08 erding automount[16977]: open_parse:168: lookup(ldap):
> cannot open parse module dc=de (/usr/lib64/autofs/parse_dc=de.so: cannot
> open shared object file: No such file or directory)
> Jun 11 21:29:08 erding automount[16977]: lookup_init:1493: lookup(ldap):
> failed to open parse context
> Jun 11 21:29:08 erding automount[16977]: mount_autofs_indirect: failed
> to read map for /company/projekte
> Jun 11 21:29:08 erding automount[16977]: handle_mounts: mount of
> /company/projekte failed!
> Jun 11 21:29:08 erding automount[16977]: mount_mount: mount(autofs):
> failed to create submount for /company/projekte
> 
> 
> I were able to track the issue down to
> autofs-5.0.4-easy-alloca-replacements.patch as being the culprit. (I can
> automount just fine with all patches up th
> autofs-5.0.4-make-MAX_ERR_BUF-and-PARSE_MAX_BUF-use-easier-to-audit.patch,
> things start to break from the moment on I apply
> autofs-5.0.4-easy-alloca-replacements.patch.)
> 
> 
> I'm willing to provide any further informations that might be required
> to fix this issue.

Looks like a known problem.

The patch autofs-5.0.4-fix-map-type-info-parse-error.patch on kernel.org
will get you by until I get around to fixing it properly. That will be
an additional patch to this one so shouldn't cause further problems
using this one. The CHANGELOG hunk obviously won't apply unless you also
apply the other 7 patches after
autofs-5.0.4-use-srv-query-for-domain-dn.patch.

Ian
