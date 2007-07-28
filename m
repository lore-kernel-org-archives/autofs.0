From: Ian Kent <raven@themaw.net>
Subject: Re: using both nfs3 and nfs4 in a single mount map
Date: Sat, 28 Jul 2007 15:15:15 +0800
Message-ID: <1185606915.8326.22.camel@raven.themaw.net>
References: <1185549849.22250.35.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185550740.3203.80.camel@raven.themaw.net>
	<1185551130.22250.41.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1185551130.22250.41.camel@sangay.TechFak.Uni-Bielefeld.DE>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

On Fri, 2007-07-27 at 17:45 +0200, Lukas Kolbe wrote:
> Hi Ian,
> > 
> > I'll have to think about for a while and have a look at the code.
> 
> Thank you :)
> 
> > What does your auto_homes look like?
> 
> ypmatch is my friend:
> 
> lkolbe@komagatake ypmatch lkolbe auto_homes
> figaro:/users/rbghiwis01/rbghiwis/&
> lkolbe@komagatake ypmatch fstest auto_homes
> thor:/export/rbg/homes/staff/&
> lkolbe@komagatake ypmatch vkgnome auto_homes
> figaro:/users/stud09/stud/&
> 
> Where figaro is a Solaris 8 or 9 server serving nfs3, thor is a solaris
> 10 box serving nfs4 from zfs-volumes.

Presumably the exports are distinct, in which case using a list of
server should allow autofs to try each one?

What about trying something like:

In the master map put:
/homes	auto_homes	nosuid,grpid,nobrowse,proto=tcp,port=2049

In NIS auto_homes put:
*	thor:/export/rbg/homes/staff/& figaro:/users/rbghiwis01/rbghiwis/& figaro:/users/stud09/stud/&

With the order determined by the server likely to get the most hits.

Ensure that /etc/nsswitch has:
automount: files nis

and /etc/auto_homes, either doesn't exist or contains, as the last line,
+auto_homes

And finally this patch.
Beware, I haven't even compile tested this and I know I excluded the
NFS4 here for a reason, which I can't remember atm.

Ian

---
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 25f72b9..7083200 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -130,8 +130,10 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 
 	if (strcmp(fstype, "nfs4") == 0)
 		vers = NFS4_VERS_MASK | NFS_PROTO_MASK;
-	else
+	else if (strcmp(fstype, "nfs") == 0)
 		vers = NFS_VERS_MASK | NFS_PROTO_MASK;
+	else
+		vers = NFS4_VERS_MASK | NFS_VERS_MASK | NFS_PROTO_MASK;
 
 	if (!parse_location(&hosts, what)) {
 		warn(ap->logopt, MODPREFIX "no hosts available");
