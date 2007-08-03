From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs 4 and 5 with nfs4
Date: Fri, 03 Aug 2007 12:19:49 +0800
Message-ID: <1186114789.3573.21.camel@raven.themaw.net>
References: <46A745D5.7080603@cohtech.com>
	<1186114144.3573.14.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1186114144.3573.14.camel@raven.themaw.net>
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
To: Howard Wilkinson <howard@cohtech.com>
Cc: autofs@linux.kernel.org

On Fri, 2007-08-03 at 12:09 +0800, Ian Kent wrote:
> > Is there a map syntax that would work round this? Ideally I would like
> > the map to be the same on all hosts, I can have different maps on the
> > autofs4 and autofs5 hosts easily but would not want to have a separate
> > map per host.
> 
> I had a look at the code which mounts these and it looks like if you
> adding a port= option will force an NFS mount to be done.
> 
> Want to give it a try?
> 
> Historically the nosymlink would have had the same affect but, even
> though the mount code looks for it it doesn't use it anymore. That may
> not be such a bad thing given the name of the option and the fact that
> it's not mentioned in the man pages. If this achieves what's needed then
> I'd rather document the use of the port= option in the man pages and
> keep the nosymlink a candidate for the chopping block.

But I just noticed you'd like the same map for v4 and v5.

Also, on second thoughts, I need to at least continue to support it for
the sake of the v4 users.

Please try this patch and let me know if it resolves the problem.

Ian

---
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 25f72b9..e7a9a8a 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -214,7 +214,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 			port_opt = strstr(nfsoptions, "port=");
 
 		/* Port option specified, don't try to bind */
-		if (!port_opt && this->proximity == PROXIMITY_LOCAL) {
+		if (!nosymlink && !port_opt && this->proximity == PROXIMITY_LOCAL) {
 			/* Local host -- do a "bind" */
 			const char *bind_options = ro ? "ro" : "";
