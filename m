From: werme@hp.com
Subject: Re: softlink creation on startup
Date: Fri, 21 Jan 2005 15:46:10 -0500 (EST)
Message-ID: <200501212046.j0LKkAw0001265711@anw.zk3.dec.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robert.dege@ngc.com
Cc: autofs@linux.kernel.org

robert.dege@ngc.com wrote:
   I'm trying to integrate a linux box into a TRU64 UNIX network, and
   am seeking some insight with automounting.  Our TRU64 network uses
   NIS to propagate data among our client systems.  The systems have
   been configured to use the NIS auto.master map to establish
   automount links.

   Here's a snippet of the file:
   
   # Razor Links
   /newrazor       -rw,intr        newrazor:/razor
   /arazor         -rw,intr        cerberus:/razor
   
   # Misc. Alpha Links
   /home           -rw,intr        mercury:/home
   /vxdisk         -rw,intr        as2508:/vxdisk

Is that from auto.master map or something like auto.direct?  I.e.,
auto.master often has a line like:

  % ypcat -k auto.master
  /home auto.home         -nosuid,hard,intr
  /net -hosts             -nosuid,hard,intr
  /- auto.direct          -nosuid,hard,intr

Then auto.direct has something like:

  % ypcat -k auto.direct | grep release   
  /doclib/release_notes -rw,nosuid,soft server:/doclib/release_notes

(Pay no attention to that soft mount flag.  They are the work of the devil.)

At startup, automount does _not_ create symbolic links.  It _does_ create
"intercept points," NFS mounts that go to a NFS server within the automount
daemon:

  client 24% mount -e | grep non-ODE
  client:(pid6035) on /usr/doc/public/non-ODE type nfs (v2, ...)

When you access the intercept point, the mount is done and then the
symbolic link is created:

  client 25% file /usr/doc/public/non-ODE
  /usr/doc/public/non-ODE:        symbolic link to /tmp_mnt/server/usr/doc/public/non-ODE

  client 26% mount -e | grep non-ODE
  client:(pid6035) on /usr/doc/public/non-ODE type nfs (v2, ...)
  server:/usr/doc/public/non-ODE on /tmp_mnt/server/usr/doc/public/non-ODE type nfs (v3, ...)

   I am already aware that the auto.master file format is incompatible
   with autofs.  I am working with automount2amd to generate a local
   auto.master file for the linux box.  The feature that I'm looking
   for is the soft link generation upon autofs startup.

That's generally considered a misfeature for various reasons and is
"corrected" in autofs implementations.

   In TRU64,
   when automount is started, softlinks are created in root, based on
   the NIS auto.master map.  So, an ls -l in a TRU64 client would
   display this:
   
   ...
   lrwxrwxrwx   1 root     system        20 Jan 17 16:46 arazor -> /.automount/arazor

No, per above.  (The /.automount directory is due to overriding the /tmp_mnt
default.)

   My question is this: Is it possible to configure auto.master so
   that when autofs starts up, These soft links will be automatically
   created.  When autofs is shutdown, the softlinks are automatically
   removed.

Oh, a Linux autofs question!  Beats me.  I'll yield the floor.  :-)

BTW, Tru64 has a HP implemented autofs since V5.0 or so.

  # man -k autofs
  autofsd, autofs (8)     - Automatically and transparently mounts and
                            unmounts NFS file systems
  autofsmount (8)         - Installs and removes AutoFS intercept points
  sys_attrs_autofs (5)    - autofs subsystem attributes

	-Ric Werme

P.S. This Email might not make it out to the list.  Rob, if you don't see
it, please post it for me.

-- 
Eric (Ric) Werme         |  werme@zk3.dec.com
Hewlett-Packard Co.      |  http://werme.8m.net/
