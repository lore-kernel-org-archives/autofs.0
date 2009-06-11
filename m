From: aaron <aaron@cs.tu-berlin.de>
Subject: automounting issues: cannot open parse module dc=de
Date: Thu, 11 Jun 2009 21:55:04 +0200
Message-ID: <4A316118.3030205@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Hi everyone at autofs discussion list,

I'm having some serious problems with the automounter daemon on my
system. I'm using gentoo and everything was fine (besides some regular
autofs crashes) using autofs-5.0.4-r2 (that's autofs-5.0.4 and all
patches up to autofs-5.0.4-fix-quoted-mess.patch). After upgrading to
autofs-5.0.4-r3 (that's autofs-5.0.4 and all patches up to
autofs-5.0.4-dont-umount-existing-direct-mount-on-reread.patch)
automounting suddenly failed to work for me. The situation hasn't
changed with autofs-5.0.4-r4 (that's autofs-5.0.4 and all patches up to
autofs-5.0.4-use-srv-query-for-domain-dn.patch)

Here are the errors from /var/log/messages (same happens when I try to
automount /company/home):

Jun 11 21:29:08 erding automount[16977]: open_parse:168: lookup(ldap):
cannot open parse module dc=de (/usr/lib64/autofs/parse_dc=de.so: cannot
open shared object file: No such file or directory)
Jun 11 21:29:08 erding automount[16977]: lookup_init:1493: lookup(ldap):
failed to open parse context
Jun 11 21:29:08 erding automount[16977]: mount_autofs_indirect: failed
to read map for /company/projekte
Jun 11 21:29:08 erding automount[16977]: handle_mounts: mount of
/company/projekte failed!
Jun 11 21:29:08 erding automount[16977]: mount_mount: mount(autofs):
failed to create submount for /company/projekte


I were able to track the issue down to
autofs-5.0.4-easy-alloca-replacements.patch as being the culprit. (I can
automount just fine with all patches up th
autofs-5.0.4-make-MAX_ERR_BUF-and-PARSE_MAX_BUF-use-easier-to-audit.patch,
things start to break from the moment on I apply
autofs-5.0.4-easy-alloca-replacements.patch.)


I'm willing to provide any further informations that might be required
to fix this issue.


Regards
  Olaf Freyer
