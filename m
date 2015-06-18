From: Ian Kent <ikent@redhat.com>
Subject: Re: [PATCH] autofs: handle old configuration format
Date: Thu, 18 Jun 2015 14:37:05 +0800
Message-ID: <1434609425.3898.11.camel@pluto.fritz.box>
References: <1434558586-9442-1-git-send-email-jbacik@fb.com>
	 <1434587998.2649.12.camel@pluto.fritz.box> <5582406E.2090401@fb.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <5582406E.2090401@fb.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Josef Bacik <jbacik@fb.com>
Cc: autofs@vger.kernel.org

On Wed, 2015-06-17 at 20:52 -0700, Josef Bacik wrote:
> On 06/17/2015 05:39 PM, Ian Kent wrote:
> > Hi Josef,
> >
> > Hope you are well.
> >
> > On Wed, 2015-06-17 at 09:29 -0700, Josef Bacik wrote:
> >> This is a patch to fix
> >>
> >> http://bugzilla.centos.org/view.php?id=8614
> >>
> >> The configuration stuff was redone and it broke backwards compatiblity.
> >
> > OK, but I put quite a bit of effort in to not do that.
> >
> > I thought it more likely I'd get complaints from people not realizing an
> > old configuration left in place would override changes in the new
> > configuration.
> >
> > Can you give me an example of the problem you have seen please.
> >
> >> Unfortunately this was backported to Centos/RHEL, so configurations that were
> >> working in 6.4 suddenly broke in 6.6, which is not helpful.  Fix this by
> >> noticing if we are looking at the old configuration file, strip out the DEFAULT_
> >> bit of the variable if it is there and tolower the rest of the string.  This
> >> makes it so our old configuration works properly and now people get their home
> >> dirs automounted properly with either versions of autofs.  Thanks,
> >
> > The way this is supposed to work is that the new configuration file is
> > read and then the old one is read and anything in the old configuration
> > file should override anything in the new one.
> >
> > When looking up configuration values if the key isn't found and the key
> > starts with "DEFAULT_" the the key is looked for again without the
> > "DEFAULT_". Also, key comparisons are case insensitive so that shouldn't
> > make a difference.
> 
> Oh now I realize why it's not working.  When you do defaults_get_schema 
> you are looking up the new values, so your check in conf_lookup isn't 
> helping anything, because we aren't looking up DEFAULT_*, we're looking 
> up the new values.  And since we don't have those variables set in 
> autofs.conf they don't get set until we load the old things, and so we 
> have DEFAULT_* set in the conf but not the normal variables.  So we can 
> do what I've done here, or change conf_lookup to add the DEFAULT_ to the 
> front of anything we search for if we can't find it.  Thanks,

Yes, that looks to be the case.

I can't just strip the DEFAULT_ prefix on adding values because there
could be configuration key names that are meant to have the prefix.

So I think it's best to try and handle this in the conf_lookup()
function.

You may get some conflicts with this as it's against current upstream
but if you can resolve them, does this patch resolve the problem?

If you have difficulty with conflicts then give me the package revision
and I'll back port the patch to it so you can test it.

autofs-5.1.1 - fix config old name lookup

From: Ian Kent <raven@themaw.net>

There are three cases needed to handle configuration name lookup.

First there's the configuration key name, the name match is case
insensitive so the recent case change isn't a seperate case.

But the much older configuration key names that began with "DEFAULT_"
need special handling.

There are two cases that need to be covered:
1) an old name is given but a new name needs to be located.
2) a new name is given but an old name needs to be located.

Only 1) is currently covered, so fix that in conf_lookup().

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG      |    1 +
 lib/defaults.c |   13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 1fcb763..606817c 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -2,6 +2,7 @@
 =======================
 - fix left mount count return from umount_multi_triggers().
 - fix rwlock unlock crash.
+- fix config old name lookup.
 
 21/04/2015 autofs-5.1.1
 =======================
diff --git a/lib/defaults.c b/lib/defaults.c
index 5711e65..dc162a6 100644
--- a/lib/defaults.c
+++ b/lib/defaults.c
@@ -31,6 +31,8 @@
 #include "log.h"
 #include "automount.h"
 
+#define MAX_CONF_KEY_LEN		40
+
 #define AUTOFS_GLOBAL_SECTION		"autofs"
 #define AMD_GLOBAL_SECTION		"amd"
 
@@ -728,6 +730,17 @@ static struct conf_option *conf_lookup(const char *section, const char *key)
 		 */
 		if (strlen(key) > 8 && !strncasecmp("DEFAULT_", key, 8))
 			co = conf_lookup_key(section, key + 8);
+		else {
+			/* A new key name has been given but the value
+			 * we seek is stored under an old key name (which
+			 * includes the "DEFAULT_" prefix.
+			 */
+			char old_key[MAX_CONF_KEY_LEN];
+
+			strcpy(old_key, "DEFAULT_");
+			strcat(old_key, key);
+			co = conf_lookup_key(section, old_key);
+		}
 	}
 
 	return co;


