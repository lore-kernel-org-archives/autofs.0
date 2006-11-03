From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] fix string comparison to do full matches
Date: Fri, 03 Nov 2006 16:30:30 -0500
Message-ID: <x49odro1amh.fsf@segfault.boston.devel.redhat.com>
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
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@linux.kernel.org>

Hi, Ian, list,

	while(1) {
		entry = read_one(f, mkey, mapent);
		if (entry)
			if (strncmp(mkey, key, key_len) == 0) {
				fclose(f);
				return cache_update(root, key, mapent, age);
			}

		if (feof(f))
			break;
	}

The strncmp above will match a partial key in the cache.  What I mean by
that is, if we are looking up "foo", and there is an entry for "foobar",
that code would incorrectly update the "foobar" entry with the value for
the key "foo".  The fix is simple, and has been in the RHEL 4 code for some
time.

I tested it as follows:

---

Setup the automounter to mount a local map (nsswitch should have 'automount: files')

The auto.master file should have the following entry:
/misc   /etc/auto.misc --timeout=3

The /etc/auto.misc file should have the following entries:
foo2            mountpoint1
foo             mountpoint2

where mountpoint1 & mountpoint2 are two different mountpoints (ie.
tng4-1:/net/1/1/1 & tng4-1:/net/1/1/2)

Run 'ls /misc/foo ; ls /misc/foo2'

You should get a list of the files in both mountpoints.  Wait 10 seconds.  Run
df and make sure both dirs were unmounted.

touch /etc/auto.misc

Run 'ls /misc/foo ; ls /misc/foo2'

You should have the same output as the first 'ls /misc/foo ; ls /misc/foo2'

---

This patch is again from Chris Feist.  Comments welcome.

-Jeff

diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index 2eb002e..49d1155 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -345,7 +345,8 @@ static int lookup_one(const char *root,
 	while(1) {
 		entry = read_one(f, mkey, mapent);
 		if (entry)
-			if (strncmp(mkey, key, key_len) == 0) {
+			if (strlen(mkey) == key_len &&
+			    strncmp(mkey, key, key_len) == 0) {
 				fclose(f);
 				return cache_update(root, key, mapent, age);
 			}
