From: Daniel Andre Vaquero <daniel@vision.ime.usp.br>
Subject: Re: Bug#304245: patch - NFS mounts occasionally fail
Date: Sun, 24 Apr 2005 21:22:30 -0300
Message-ID: <20050425002230.GA29407@vision.ime.usp.br>
References: <20050417154240.GA17232@uio.no>
	<20050417181827.GA13101@vision.ime.usp.br>
	<Pine.LNX.4.62.0504182142090.14946@donald.themaw.net>
	<42640E89.7090005@redhat.com>
	<Pine.LNX.4.62.0504241602310.18935@donald.themaw.net>
	<Pine.LNX.4.62.0504241728230.20970@donald.themaw.net>
	<20050424161805.GA15363@vision.ime.usp.br>
	<Pine.LNX.4.62.0504250202400.5096@donald.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504250202400.5096@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>, Chris Feist <cfeist@redhat.com>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 25, 2005 at 02:10:14AM +0800, raven@themaw.net wrote:
> On Sun, 24 Apr 2005, Daniel Andre Vaquero wrote:
> 
> >I would also suggest a change in the name of this function to something
> >like is_replicated_entry. Multi-mounts and replicated mounts are
> >different things, and in this case it could confuse the reader.
> 
> Perhaps. But they are handled by the same code.
> The simple replicated mount entry is a special case of a multi-mount 
> entry as far as the code is concerned. At least that's the way it is now.

Sorry, I didn't see that it is now also being used in parse_sun.c. Then
I agree that it is OK.

I have tested version 4.1.4 plus the three new patches from kernel.org,
and found a bug when using bogus names in multi-mounts. The test case is:

/etc/auto.testing

foo     -ro,hard,intr \
        /dir/bar        bogus:/usr/src \
        /dir/baz        morebogus:/usr/share/doc

When the function get_best_mount tries to resolve the bogus names, there is a
host lookup failure. Then it returns the winner as local, and automount does
a mount --bind. But the correct behaviour would be a mount failure.

The corresponding log entries follows attached. I have also made and tested
a little patch to fix it (and a brace missing in
autofs-4.1.4-multi-parse-fix.patch), that is attached as well.

Daniel

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bogus.log"

Apr 24 20:01:51 mybox automount[18557]: attempting to mount entry /testing/foo
Apr 24 20:01:51 mybox automount[19519]: lookup(file): foo -> -ro,hard,intr         /dir/bar        bogus:/usr/src         /dir/baz        morebogus:/usr/share/doc
Apr 24 20:01:51 mybox automount[19519]: parse(sun): expanded entry: -ro,hard,intr         /dir/bar        bogus:/usr/src         /dir/baz        morebogus:/usr/share/doc
Apr 24 20:01:51 mybox automount[19519]: parse(sun): dequote("ro,hard,intr") -> ro,hard,intr
Apr 24 20:01:51 mybox automount[19519]: parse(sun): gathered options: ro,hard,intr
Apr 24 20:01:51 mybox automount[19519]: parse(sun): dequote("/dir/bar") -> /dir/bar
Apr 24 20:01:51 mybox automount[19519]: parse(sun): dequote("bogus:/usr/src") -> bogus:/usr/src
Apr 24 20:01:51 mybox automount[19519]: parse(sun): dequote("/dir/baz") -> /dir/baz
Apr 24 20:01:51 mybox automount[19519]: parse(sun): dequote("morebogus:/usr/share/doc") -> morebogus:/usr/share/doc
Apr 24 20:01:51 mybox automount[19519]: parse(sun): multimount: morebogus:/usr/share/doc on /dir/baz with options ro,hard,intr
Apr 24 20:01:51 mybox automount[19519]: parse(sun): mounting root /testing/foo, mountpoint dir/baz, what morebogus:/usr/share/doc, fstype nfs, options ro,hard,intr 
Apr 24 20:01:51 mybox automount[19519]: mount(nfs): root=/testing/foo name=dir/baz what=morebogus:/usr/share/doc, fstype=nfs, options=ro,hard,intr
Apr 24 20:01:51 mybox automount[19519]: mount(nfs): nfs options="ro,hard,intr", nosymlink=0, ro=1
Apr 24 20:01:51 mybox automount[19519]: mount(nfs): is_local_mount: morebogus:/usr/share/doc
Apr 24 20:01:51 mybox automount[19519]: mount(nfs): host morebogus: lookup failure
Apr 24 20:01:51 mybox automount[19519]: mount(nfs): host morebogus:/usr/share/doc: is localhost
Apr 24 20:01:51 mybox automount[19519]: mount(nfs): from morebogus:/usr/share/doc elected /usr/share/doc
Apr 24 20:01:51 mybox automount[19519]: mount(nfs): dir/baz is local, doing bind
Apr 24 20:01:51 mybox automount[19519]: mount(bind): calling mkdir_path /testing/foo/dir/baz
Apr 24 20:01:51 mybox automount[19519]: mount(bind): calling mount --bind -s  -o ro /usr/share/doc /testing/foo/dir/baz
Apr 24 20:01:51 mybox automount[19519]: mount(bind): mounted /usr/share/doc type bind on /testing/foo/dir/baz
Apr 24 20:01:51 mybox automount[19519]: parse(sun): multimount: bogus:/usr/src on /dir/bar with options ro,hard,intr
Apr 24 20:01:51 mybox automount[19519]: parse(sun): mounting root /testing/foo, mountpoint dir/bar, what bogus:/usr/src, fstype nfs, options ro,hard,intr 
Apr 24 20:01:51 mybox automount[19519]: mount(nfs): root=/testing/foo name=dir/bar what=bogus:/usr/src, fstype=nfs, options=ro,hard,intr
Apr 24 20:01:51 mybox automount[19519]: mount(nfs): nfs options="ro,hard,intr", nosymlink=0, ro=1
Apr 24 20:01:51 mybox automount[19519]: mount(nfs): is_local_mount: bogus:/usr/src
Apr 24 20:01:52 mybox automount[19519]: mount(nfs): host bogus: lookup failure
Apr 24 20:01:52 mybox automount[19519]: mount(nfs): host bogus:/usr/src: is localhost
Apr 24 20:01:52 mybox automount[19519]: mount(nfs): from bogus:/usr/src elected /usr/src
Apr 24 20:01:52 mybox automount[19519]: mount(nfs): dir/bar is local, doing bind
Apr 24 20:01:52 mybox automount[19519]: mount(bind): calling mkdir_path /testing/foo/dir/bar
Apr 24 20:01:52 mybox automount[19519]: mount(bind): calling mount --bind -s  -o ro /usr/src /testing/foo/dir/bar
Apr 24 20:01:52 mybox automount[19519]: mount(bind): mounted /usr/src type bind on /testing/foo/dir/bar
Apr 24 20:01:52 mybox automount[18557]: handle_child: got pid 19519, sig 0 (0), stat 0 
Apr 24 20:01:52 mybox automount[18557]: sig_child: found pending iop pid 19519: signalled 0 (sig 0), exit status 0
Apr 24 20:01:52 mybox automount[18557]: send_ready: token=1402 

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="autofs-4.1.4-non-replicated-local-fix.patch"

diff -Npru autofs-4.1.4.orig/modules/mount_nfs.c autofs-4.1.4/modules/mount_nfs.c
--- autofs-4.1.4.orig/modules/mount_nfs.c	2005-04-24 20:28:25.000000000 -0300
+++ autofs-4.1.4/modules/mount_nfs.c	2005-04-24 19:59:13.000000000 -0300
@@ -191,7 +191,7 @@ int get_best_mount(char *what, const cha
 				*pstrip = '\0';
 
 		/* Check if the host is the localhost */
-		if (is_local_mount(p)) {
+		if (is_local_mount(p) > 0) {
 			debug(MODPREFIX "host %s: is localhost", p);
 
 			/* Strip off hostname and ':' */
diff -Npru autofs-4.1.4.orig/modules/parse_sun.c autofs-4.1.4/modules/parse_sun.c
--- autofs-4.1.4.orig/modules/parse_sun.c	2005-04-24 20:28:25.000000000 -0300
+++ autofs-4.1.4/modules/parse_sun.c	2005-04-24 20:35:01.000000000 -0300
@@ -841,6 +841,7 @@ int parse_mount(const char *root, const 
 			if (*p != '/') {
 				l = 0;
 				path = dequote("/", 1);
+			}
 			else
 				path = dequote(p, l = chunklen(p, 0));
 			if (!path) {

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--AhhlLboLdkugWU4S--

