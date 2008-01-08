From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: Kernel patch to better support bind-mounts
Date: Tue, 08 Jan 2008 15:41:51 +0100
Message-ID: <1199803311.27093.5.camel@srss>
References: <1199788697.26268.24.camel@srss>
	<1199798508.3155.48.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1199798508.3155.48.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi Ian!

> Sure, but you'll need to give me a while to re-familiarize myself with
> the history and think about it for a while.

Of course. This patch was sitting here since before christmas and I only
now came around actually talking about it, so no stress with that :)

> > eclipse-3.1 \
> >   /bin          -rw,nosuid,grpid          fileserver:/volumes/vol1/eclipse-3.1/bin.linx86
> > eclipse \
> >   /bin          -rw,nosuid,grpid          :/vol/eclipse-3.1/bin
> 
> Mounts for these multiple offsets are triggered in the same way as
> direct mounts, they are triggered when autofs4_follow_link is called by
> the VFS.
> 
> > 
> > Accessing /vol/eclipse/bin now works flawlessly. But given this map:
> > 
> > jdk-1.5.13 -rw,nosuid,grpid fileserver:/export/stud/vol/jdk-1.5.13/linx86
> > jdk-1.5    -rw,nosuid,grpid :/vol/jdk-1.5.13
> 
> But these are indirect mounts and they are triggered by calling either
> autofs4_lookup or autofs4_revalidate and then indirectly
> try_to_fill_dentry, which is where you added the change I think.

Ok, thanks, then I understand a bit better what's actually happening
there.

> What kernel version is this patch against?

I tested it (IIRC) against 2.6.18 (from debian) and 2.6.23 (from
kernel.org git) - autofs-code doesn't seem to have changed much.

> Ian


-- 
Lukas
