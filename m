From: Ian Kent <raven@themaw.net>
Subject: Re: autofs {3, 4,
 5} and bind mounts which point to other automount points
Date: Fri, 25 Aug 2006 19:18:09 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0608251917030.30523@raven.themaw.net>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608250926270.6382@raven.themaw.net>
	<Pine.LNX.4.64.0608250736190.10216@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608251506180.25004@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608251506180.25004@raven.themaw.net>
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
To: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Cc: autofs@linux.kernel.org

On Fri, 25 Aug 2006, Ian Kent wrote:

> On Fri, 25 Aug 2006, Matt Bernstein wrote:
> 
> > At 09:29 +0800 Ian Kent wrote:
> > 
> > > On Thu, 24 Aug 2006, Matt Bernstein wrote:
> > > > +/* 'what' may itself be on an automounted file system so we need to
> > > > access it */
> > > > +/* to ensure it gets mounted before calling wait_for_lock() inorder to
> > > > avoid a*/
> > > > +/* long delay */
> > > > +               (void)access(what,F_OK);
> > > 
> > > That can lead to corruption of /etc/mtab.
> > > That's why the lock was introduced.
> > > 
> > > In v5 the locking can be disabled as most people have updated mount(8) these
> > > days.
> > 
> > Thanks--is the locking disabled, or do we need to patch the source? (I haven't
> > looked at it yet.)
> > 
> > > Someone else has reported that bind mounts aren't working with v5.
> > > It would be good to resolve this but I need more info.
> > > A debug log would be best.
> > 
> > I set DEFAULT_LOGGING="debug" in /etc/sysconfig/autofs (this is
> > autofs-5.0.1-0.rc1.16.x86_64 in FC6test), and I got this in /var/log/messages:
> > 
> > Aug 25 07:31:29 laurel automount[17274]: attempting to mount entry /homes/mb
> > Aug 25 07:31:29 laurel automount[17274]: mount_mount: mount(nfs): no hosts
> > available
> 
> Mmmm ... I shouldn't be defaulting to NFS for a ":" escaped mount.

Could you try this patch please.

Ian

--

diff --git a/modules/parse_sun.c b/modules/parse_sun.c
index c132422..190499c 100644
--- a/modules/parse_sun.c
+++ b/modules/parse_sun.c
@@ -508,25 +508,35 @@ static int sun_mount(struct autofs_point
 	mountpoint = alloca(namelen + 1);
 	sprintf(mountpoint, "%.*s", namelen, name);
 
-	what = alloca(loclen + 1);
-	if (*loc == ':') {
-		memcpy(what, loc + 1, loclen - 1);
-		what[loclen - 1] = '\0';
-	} else {
+	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
+	if (!strcmp(fstype, "nfs")) {
+		what = alloca(loclen + 1);
 		memcpy(what, loc, loclen);
 		what[loclen] = '\0';
-	}
 
-	debug(ap->logopt,
-	    MODPREFIX
-	    "mounting root %s, mountpoint %s, what %s, fstype %s, options %s",
-	    root, mountpoint, what, fstype, options);
+		debug(ap->logopt, MODPREFIX
+		      "mounting root %s, mountpoint %s, "
+		      "what %s, fstype %s, options %s",
+		      root, mountpoint, what, fstype, options);
 
-	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
-	if (!strcmp(fstype, "nfs")) {
 		rv = mount_nfs->mount_mount(ap, root, mountpoint, strlen(mountpoint),
 					    what, fstype, options, mount_nfs->context);
 	} else {
+		what = alloca(loclen + 1);
+		if (*loc == ':') {
+			loclen--;
+			memcpy(what, loc + 1, loclen);
+			what[loclen] = '\0';
+		} else {
+			memcpy(what, loc, loclen);
+			what[loclen] = '\0';
+		}
+
+		debug(ap->logopt, MODPREFIX
+		      "mounting root %s, mountpoint %s, "
+		      "what %s, fstype %s, options %s",
+		      root, mountpoint, what, fstype, options);
+
 		/* Generic mount routine */
 		rv = do_mount(ap, root, mountpoint, strlen(mountpoint), what, fstype,
 			      options);
diff --git a/modules/replicated.c b/modules/replicated.c
index aa484b3..7558383 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -587,14 +587,16 @@ int prune_host_list(struct host **list, 
 	while (this && this->proximity == proximity) {
 		struct host *next = this->next;
 
-		status = get_vers_and_cost(this, vers);
-		if (!status) {
-			if (this == first) {
-				first = next;
-				if (next)
-					proximity = next->proximity;
+		if (this->name) {
+			status = get_vers_and_cost(this, vers);
+			if (!status) {
+				if (this == first) {
+					first = next;
+					if (next)
+						proximity = next->proximity;
+				}
+				delete_host(list, this);
 			}
-			delete_host(list, this);
 		}
 		this = next;
 	}
@@ -674,11 +676,15 @@ int prune_host_list(struct host **list, 
 	this = first;
 	while (this) {
 		struct host *next = this->next;
-		status = get_supported_ver_and_cost(this, selected_version);
-		if (status) {
-			this->version = selected_version;
-			remove_host(list, this);
+		if (!this->name)
 			add_host(&new, this);
+		else {
+			status = get_supported_ver_and_cost(this, selected_version);
+			if (status) {
+				this->version = selected_version;
+				remove_host(list, this);
+				add_host(&new, this);
+			}
 		}
 		this = next;
 	}
@@ -775,6 +781,34 @@ static int add_path(struct host *hosts, 
 	return 1;
 }
 
+static int add_local_path(struct host **hosts, const char *path)
+{
+	struct host *new;
+	char *tmp;
+
+	tmp = strdup(path);
+	if (!tmp)
+		return 0;
+
+	new = malloc(sizeof(struct host));
+	if (!new) {
+		free(tmp);
+		return 0;
+	}
+
+	memset(new, 0, sizeof(struct host));
+
+	new->path = tmp;
+	new->proximity = PROXIMITY_LOCAL;
+	new->version = NFS_VERS_MASK;
+	new->name = new->addr = NULL;
+	new->weight = new->cost = 0;
+
+	add_host(hosts, new);
+
+	return 1;
+}
+
 int parse_location(struct host **hosts, const char *list)
 {
 	char *str, *p, *delim;
@@ -829,18 +863,25 @@ int parse_location(struct host **hosts, 
 					*next++ = '\0';
 				}
 
-				if (!add_host_addrs(hosts, p, weight)) {
-					if (empty) {
+				if (p != delim) {
+					if (!add_host_addrs(hosts, p, weight)) {
+						if (empty) {
+							p = next;
+							continue;
+						}
+					}
+
+					if (!add_path(*hosts, path, strlen(path))) {
+						free_host_list(hosts);
+						free(str);
+						return 0;
+					}
+				} else {
+					if (!add_local_path(hosts, path)) {
 						p = next;
 						continue;
 					}
 				}
-
-				if (!add_path(*hosts, path, strlen(path))) {
-					free_host_list(hosts);
-					free(str);
-					return 0;
-				}
 			} else if (*delim != '\0') {
 				*delim = '\0';
 				next = delim + 1;
