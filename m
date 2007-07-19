From: Ian Kent <raven@themaw.net>
Subject: Re: Seeing some 5.0.1 stop expiring mounts
Date: Thu, 19 Jul 2007 20:03:48 +0800
Message-ID: <1184846628.3258.55.camel@raven.themaw.net>
References: <20070717195431.GA14624@cornholio.qualcomm.com>
	<1184741167.4178.50.camel@raven.themaw.net>
	<20070718213945.GA7455@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070718213945.GA7455@cornholio.qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-07-18 at 14:39 -0700, Mike Marion wrote:
> On Wed, Jul 18, 2007 at 02:46:07PM +0800, Ian Kent wrote:
> 
> > Might be worth considering going to 5.0.2, especially since you have a
> > busy site, as a nasty deadlock in the alarm handler has been fixed. 
> 
> Unfortunately, we can't.  I've since found out (through trial and error)
> that the patch:
> > > autofs-5.0.1-map-update-source-only.patch
> 
> is completely broken for us, and it appears to be part of the 5.0.2
> codebase now.

Indeed.

I think I've identified the problem but I'll need to look more closely
at it.

In the meantime it would be great if you could try this patch, in
addition to the patch above, and check if there are any other problems
with it.

The patch is against the current git repo but applies against a fairly
up to date 5.0.1 tree (it looks correct) with a small offset.

Ian

---
diff --git a/daemon/lookup.c b/daemon/lookup.c
index 70b9e02..4f2b318 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -325,6 +325,7 @@ static int read_file_source_instance(struct autofs_point *ap, struct map_source
 		instance->recurse = map->recurse;
 		instance->depth = map->depth;
 	}
+	instance->stale = map->stale;
 
 	return do_read_map(ap, instance, age);
 }
@@ -346,6 +347,7 @@ static int read_source_instance(struct autofs_point *ap, struct map_source *map,
 		instance->recurse = map->recurse;
 		instance->depth = map->depth;
 	}
+	instance->stale = map->stale;
 
 	return do_read_map(ap, instance, age);
 }
