From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Subject: Re: autofs-4.0.0 last chance
Date: Mon, 1 Sep 2003 13:38:42 +0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <664953843.20030901133842@wildgate.miee.ru>
References: <Pine.LNX.4.44.0308262051110.1831-100000@raven.themaw.net>
Reply-To: "Ruslan U. Zakirov" <cubic@wildgate.miee.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------413E19A1F1EAB2B"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308262051110.1831-100000@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs mailing list <autofs@linux.kernel.org>

------------413E19A1F1EAB2B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

IK> I intend to release autofs-4.0.0.

IK> If anyone has any bug reports or patches for autofs-4.0.0 please forward 
IK> them to me by this Friday 08/29. Anything after this will have to go into 
IK> sebsequent point releases.

IK> Cheers all
IK> Ian

Hello.
Glad to see that someone take this project in his hands.

I've reported problems some time ago about pre 10 and now I send
letter with attachments that I was sending to the list.]
            Best regards. Ruslan.

PS: One patch and expiration problem reports.
I don't have time to write full report that was missed somewhere about
smbfs mounts. I remember that this file system through own design
refresh mount point time to time and without workarounds(hacks) we couldn't
detect who do it user or samba userspace daemon. I've writed patch
that look at command name that cause access refresh to the node, but I
don't think that it's good idea.
Patch is for submounts. Useful when one script(program map) generate -Dkey=value,
then autofs daemon send this values to submounts with program map
types as arguments.
------------413E19A1F1EAB2B
Content-Type: message/rfc822;
	name="[autofs] 2.5 autofs-pre10 submount smbfs expire problems.EML"
Content-Disposition: attachment;
	filename="[autofs] 2.5 autofs-pre10 submount smbfs expire problems.EML"

Date: Fri, 18 Apr 2003 20:23:01 +0400
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <54252003171.20030418202301@wr.miee.ru>
To: linux-kernel@vger.kernel.org
Subject: [autofs] 2.5+autofs-pre10+submount+smbfs expire problems.
Resent-from: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

        Hello.
I've writed "exec map", that submount another autofs with another program
map, wich return fstype=smbfs.
I've got tree
autofs
      autofs submount
             smbfs
             smbfs
             ...
      autofs submount
             smbfs
             smbfs
             ...
      ...
I use autofs4 protocol, autofs4 and smbfs compiled staticaly.
Expiration problem occur. Smbfs mounts never unmount.
Autofs submounts expire ok, when I don't have third level(smbfs mounts).
Log at the end of letter.


May be I've missed something in configuration, but I don't think so.
I'll try same on 2.4.20 tonight.

             Best regards, Ruslan.

PS: Something wrong with my email and Autofs mailing list, my letters
don't appear on the list, but mailman said that I'm subscriber.


automount[9918]: expired /net/spectre-pc//music
automount[9900]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1784] timed out!
automount[9920]: running expiration on path /net/ghost-pc//Video
kernel: SMB connection re-established (-5)
automount[9920]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1785] timed out!
automount[9923]: running expiration on path /net/ghost-pc//Video
automount[9923]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1786] timed out!
automount[9939]: running expiration on path /net/ghost-pc//Video
kernel: SMB connection re-established (-5)
automount[9939]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1787] timed out!
automount[9958]: running expiration on path /net/ghost-pc//Video
automount[9958]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1788] timed out!
automount[9959]: running expiration on path /net/ghost-pc//Video
automount[9959]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1789] timed out!
automount[9962]: running expiration on path /net/ghost-pc//Video
kernel: SMB connection re-established (-5)
automount[9962]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1790] timed out!
automount[9964]: running expiration on path /net/ghost-pc//Video
automount[9964]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1791] timed out!
automount[9980]: running expiration on path /net/ghost-pc//Video
kernel: SMB connection re-established (-5)
automount[9980]: expired /net/ghost-pc//Video

------------413E19A1F1EAB2B
Content-Type: message/rfc822;
	name="[autofs] 2.5.67 autofs-pre10 submount smbfs expire problems.EML"
Content-Disposition: attachment;
	filename="[autofs] 2.5.67 autofs-pre10 submount smbfs expire problems.EML"

Date: Fri, 18 Apr 2003 20:17:49 +0400
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <127251690431.20030418201749@wr.miee.ru>
To: H . Peter Anvin <hpa@zytor.com> (Zytor Communications)
CC: autofs@linux.kernel.org, jeremy@goop.org, kernel@vger.kernel.org
Subject: [autofs] 2.5.67+autofs-pre10+submount+smbfs expire problems.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

        Hello.
I've writed "exec map", that submount another autofs with another program
map, wich return fstype=smbfs.
I've got tree
autofs
      autofs submount
             smbfs
             smbfs
             ...
      autofs submount
             smbfs
             smbfs
             ...
      ...
I use autofs4 protocol, autofs4 and smbfs compiled staticaly.
Expiration problem occur. Smbfs mounts never unmount.
Autofs submounts expire ok, when I don't have third level(smbfs mounts).
Log at the end of letter.


May be I've missed something in configuration, but I don't think so.
I'll try same on 2.4.20 tonight.

             Best regards, Ruslan.

PS: Something wrong with my email and Autofs mailing list, my letters
don't appear on the list, but mailman said that I'm subscriber.


automount[9918]: expired /net/spectre-pc//music
automount[9900]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1784] timed out!
automount[9920]: running expiration on path /net/ghost-pc//Video
kernel: SMB connection re-established (-5)
automount[9920]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1785] timed out!
automount[9923]: running expiration on path /net/ghost-pc//Video
automount[9923]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1786] timed out!
automount[9939]: running expiration on path /net/ghost-pc//Video
kernel: SMB connection re-established (-5)
automount[9939]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1787] timed out!
automount[9958]: running expiration on path /net/ghost-pc//Video
automount[9958]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1788] timed out!
automount[9959]: running expiration on path /net/ghost-pc//Video
automount[9959]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1789] timed out!
automount[9962]: running expiration on path /net/ghost-pc//Video
kernel: SMB connection re-established (-5)
automount[9962]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1790] timed out!
automount[9964]: running expiration on path /net/ghost-pc//Video
automount[9964]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1791] timed out!
automount[9980]: running expiration on path /net/ghost-pc//Video
kernel: SMB connection re-established (-5)
automount[9980]: expired /net/ghost-pc//Video

------------413E19A1F1EAB2B
Content-Type: message/rfc822;
	name="[PATCH] Exec maps and -Dkey=value parameters.EML"
Content-Disposition: attachment;
	filename="[PATCH] Exec maps and -Dkey=value parameters.EML"

Date: Fri, 18 Apr 2003 19:25:32 +0400
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <121248553440.20030418192532@wr.miee.ru>
To: autofs-bounces@linux.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
CC: autofs@linux.kernel.org, jeremy@goop.org
Subject: Re: [PATCH] Exec maps and -Dkey=value parameters.
In-Reply-To: <3E9DE71C.1000606@zytor.com>
References: <Pine.BSF.4.05.10304170245020.93387-100000@wildrose.miee.ru>
 <3E9DE71C.1000606@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

HPA> Ruslan U. Zakirov wrote:
>>       Hello, All.
>> Patch expand "exec maps" with sending not only "key name " to program, but
>> also aditional parameters key=value... Wich it parse from automounter argv
>> (-Dkey=value).
>> I think that it's really useful.
>>
HPA> I think it would make more sense to pass these as environment variables
HPA> instead.
     Hello, Peter and other.
Updated version. Uses environment and don't overwrite exist.
        Best regards, Ruslan.
PS: Any comments and corrections are wellcome. And if it will be in
the tree, I'll write patches to documentation.

--- autofs-4.0.0pre10/modules/lookup_program.c  2001-03-28 09:08:23.000000000 +0400
+++ autofs-4.0.0pre10-my/modules/lookup_program.c       2003-04-18 18:27:46.000000000 +0400
@@ -19,6 +19,7 @@
 #include <errno.h>
 #include <malloc.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <syslog.h>
 #include <unistd.h>
@@ -38,8 +39,15 @@

 #define MAPENT_MAX_LEN 4095

+struct substvar {
+  char *def;                   /* Define variable */
+  char *val;                   /* Value to replace with */
+  struct substvar *next;
+};
+
 struct lookup_context {
   const char *mapname;
+  struct substvar *svals;
   struct parse_mod *parse;
 };

@@ -49,11 +57,15 @@
                void **context)
 {
   struct lookup_context *ctxt;
+  int i;
+  struct substvar* nsv;

   if ( !(*context = ctxt = malloc(sizeof(struct lookup_context))) ) {
     syslog(LOG_CRIT, MODPREFIX "malloc: %m");
     return 1;
   }
+  memset(ctxt,0,sizeof(*ctxt));
+
   if ( argc < 1 ) {
     syslog(LOG_CRIT, MODPREFIX "No map name");
     return 1;
   }
+  memset(ctxt,0,sizeof(*ctxt));
+
   if ( argc < 1 ) {
     syslog(LOG_CRIT, MODPREFIX "No map name");
     return 1;
@@ -70,6 +82,28 @@
     syslog(LOG_WARNING, MODPREFIX "program map %s missing or not executable",
           ctxt->mapname);
   }
+
+  for (i=1;i<argc;i++) {
+    if (argv[i] && argv[i][0]=='-' && argv[i][1]=='D') {
+      nsv = malloc(sizeof(struct substvar));
+      if ( !nsv ) {
+        syslog(LOG_CRIT, MODPREFIX "malloc: %m");
+        return 1;
+      }
+      nsv->def=strdup(argv[i]+2);
+      if ( !nsv->def ) {
+        syslog(LOG_CRIT, MODPREFIX "strdup: %m");
+        return 1;
+      }
+      nsv->val = strchr(nsv->def, '=');
+      if ( nsv->val )
+        *(nsv->val++) = '\0';
+      else
+        nsv->val = "";
+      nsv->next=ctxt->svals;
+      ctxt->svals=nsv;
+    }
+  }

   if ( !mapfmt )
     mapfmt = MAPFMT_DEFAULT;
@@ -93,9 +127,19 @@
   int quoted = 0;
   int ret;
   int max_fd;
+  struct substvar* sv;

   syslog(LOG_DEBUG, MODPREFIX "looking up %s", name);
-
+
+  sv=ctxt->svals;
+  while (sv) {
+    if ((setenv(sv->def,sv->val,0))<0) {
+      syslog(LOG_WARNING, MODPREFIX "unable setenv");
+      break;
+    }
+    sv=sv->next;
+  }
+
   /* We don't use popen because we don't want to run /bin/sh plus we
      want to send stderr to the syslog, and we don't use spawnl()
      because we need the pipe hooks */
@@ -212,7 +256,7 @@
        *(errp++) = ch;
       }
     }
-}
+  }

   if ( mapp )
     *mapp = '\0';
@@ -245,7 +289,14 @@
 int lookup_done(void *context)
 {
   struct lookup_context *ctxt = (struct lookup_context *) context;
-  int rv = close_parse(ctxt->parse);
+  int rv;
+  struct substvar* tmpsv;
+  while (ctxt->svals) {
+       tmpsv=ctxt->svals;
+       ctxt->svals=tmpsv->next;
+       free(tmpsv);
+  }
+  rv = close_parse(ctxt->parse);
   free(ctxt);
   return rv;
 }

------------413E19A1F1EAB2B
Content-Type: message/rfc822; name="autofs4-pre10 unmounting problems.EML"
Content-Disposition: attachment;
	filename="autofs4-pre10 unmounting problems.EML"

Date: Mon, 26 May 2003 20:35:29 +0400
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wildgate.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <181781423828.20030526203529@wildgate.miee.ru>
To: hpa@zytor.com
CC: autofs@linux.kernel.org
Subject: autofs4-pre10 unmounting problems.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

        Hello, Peter and other.
1) Problem with unmounting during multi expire.
When we have to form list of mountpoints from mtab and fstab, we
compare all records with path. Path contains '//' and all requests
to strcmp fails. First solution is test ap.path in main() for '/' at
end and delete it. I've looked at all places where we use ap.path in
automount.c and think that this solution will be OK.
2) Second problem is smbfs user space daemon that support connections.
As I understand it pereodicaly calls SMB_IOC_NEWCONN and
in result we have call of udate_usage on the mount point. Mount point become
allways in use and never expire.
In the result of two described problems I have autofs nodes which
never expire and automount daemon that I can't stop with script.

All test was done under 2.5.69, autofs4-pre10, Slackware 8.1.

------------413E19A1F1EAB2B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

------------413E19A1F1EAB2B--

