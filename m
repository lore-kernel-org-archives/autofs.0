From: Marcel De Boer <marcel.de_boer@nokia.com>
Subject: Near-simultaneous automount of multiple directories fails
Date: Fri, 8 Apr 2016 09:55:13 +0200
Message-ID: <alpine.LRH.2.11.1604080846130.26210@carrot.ant.ipd.priv>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; format="flowed"; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Hi!

I've already reported this on the CentOS bug tracker a while ago, but I 
thought I'd report it here too.

https://bugs.centos.org/view.php?id=9835

Summarized (there's more information on the bug report): on one of our 
servers we initially saw that every few days one home directory became 
inaccessible. This happened to two different homedirectories (but only one 
at a time) out of the couple hundred we have. We traced this to 
simultaneously scheduled cron scripts running out of the affected 
homedirectories, which caused both directories to be mounted nearly 
simultaneously.

A test setup on a different machine (the primary description from the bug 
report, as the server was not stock CentOS) also showed that if we had 
cron simultaneously mount four directories every 10 minutes, only half of 
them would get mounted every time. On this machine an RPM rebuild of 
autofs made the issue disappear, but it was much more persistent on the 
server.

Eventually it seems that there is an issue in mount_mount() from 
mount_nfs.c; to my untrained eye, it looks like it can get called 
simultaneously from different threads, where they change shared 
information, probably the 'hosts' or 'tmp' lists.

I made a patch that seems to work reliably for our situation, but it's 
very crude, it just makes sure everything touching the 'hosts' list (and 
everything else during that time) does not run in parallel. It might be a 
starting point for someone who knows the code better, though. (Patch was 
made against the code used in the 5.0.5_115 CentOS 6 RPM.)

The server has received some more upgrades in the mean while, so we may no 
be able to reproduce it on that system anymore.

Kind regards,
 	Marcel de Boer


--- autofs-5.0.5-orig/modules/mount_nfs.c	2016-01-05 15:26:55.993014650 +0100
+++ autofs-5.0.5/modules/mount_nfs.c	2016-01-05 15:25:51.434011526 +0100
@@ -40,6 +40,9 @@
  static struct mount_mod *mount_bind = NULL;
  static int init_ctr = 0;

+/* Multiple access to hosts workaround */
+static pthread_mutex_t host_list_mutex = PTHREAD_MUTEX_INITIALIZER;
+
  int mount_init(void **context)
  {
  	/* Make sure we have the local mount method available */
@@ -190,7 +193,9 @@
  		      nfsoptions, nobind, nosymlink, ro);
  	}

+	pthread_mutex_lock(&host_list_mutex);
  	if (!parse_location(ap->logopt, &hosts, what, flags)) {
+        	pthread_mutex_unlock(&host_list_mutex);
  		info(ap->logopt, MODPREFIX "no hosts available");
  		return 1;
  	}
@@ -235,6 +240,7 @@

  dont_probe:
  	if (!hosts) {
+        	pthread_mutex_unlock(&host_list_mutex);
  		info(ap->logopt, MODPREFIX "no hosts available");
  		return 1;
  	}
@@ -264,6 +270,7 @@
  		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
  		error(ap->logopt,
  		      MODPREFIX "mkdir_path %s failed: %s", fullpath, estr);
+        	pthread_mutex_unlock(&host_list_mutex);
  		return 1;
  	}

@@ -300,6 +307,7 @@
  			/* Success - we're done */
  			if (!err) {
  				free_host_list(&hosts);
+                        	pthread_mutex_unlock(&host_list_mutex);
  				return 0;
  			}

@@ -325,6 +333,7 @@
  			if (!loc) {
  				char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
  				error(ap->logopt, "malloc: %s", estr);
+                        	pthread_mutex_unlock(&host_list_mutex);
  				return 1;
  			}
  			if (this->addr->sa_family == AF_INET6) {
@@ -338,6 +347,7 @@
  			if (!loc) {
  				char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
  				error(ap->logopt, "malloc: %s", estr);
+                        	pthread_mutex_unlock(&host_list_mutex);
  				return 1;
  			}
  			strcpy(loc, this->name);
@@ -365,6 +375,7 @@
  			info(ap->logopt, MODPREFIX "mounted %s on %s", loc, fullpath);
  			free(loc);
  			free_host_list(&hosts);
+                       	pthread_mutex_unlock(&host_list_mutex);
  			return 0;
  		}

@@ -374,6 +385,7 @@

  forced_fail:
  	free_host_list(&hosts);
+	pthread_mutex_unlock(&host_list_mutex);

  	/* If we get here we've failed to complete the mount */



-- 
Marcel de Boer
Test engineer, Service Routing R&D, IP/Optical Networks
Nokia, Antwerp, Belgium
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
