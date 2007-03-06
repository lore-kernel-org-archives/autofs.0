From: Matthias Koenig <mkoenig@suse.de>
Subject: [PATCH] autofs fails to recognize filesystems given with
	LABEL or UUID
Date: Tue, 06 Mar 2007 15:40:42 +0100
Message-ID: <n7xps7m4eqd.fsf@sor.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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
To: autofs mailing list <autofs@linux.kernel.org>

--=-=-=

Hi,

after applying the patch autofs-4.1.4-dont_create_remote_dirs.patch
we noticed that autofs does not create mountpoints for filessystems,
which are specified in fstab with LABEL or UUID. This is because the
contained_in_local_fs() function does not recognize the keywords.
This also happens in autofs 5.0.1.
Patch to fix this is below.

Matthias


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=autofs-4.1.4-fix_contained_check.patch

Index: autofs-4.1.4/lib/mounts.c
===================================================================
--- autofs-4.1.4.orig/lib/mounts.c
+++ autofs-4.1.4/lib/mounts.c
@@ -315,7 +315,9 @@ int contained_in_local_fs(const char *pa
 						ret = 1;
 				} else
 					ret = 1;
-			}
+			} else if (!strncmp("LABEL=", this->fs_name, 6) ||
+				   !strncmp("UUID=", this->fs_name, 5))
+				ret = 1;
 			break;
 		}
 	}

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=-=-=--

