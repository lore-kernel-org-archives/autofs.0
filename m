From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] nested mounts with loop
Date: Mon, 08 Oct 2007 12:55:21 +0800
Message-ID: <1191819321.3129.12.camel@raven.themaw.net>
References: <n7xir5ybts0.fsf@sor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <n7xir5ybts0.fsf@sor.suse.de>
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
To: Matthias Koenig <mkoenig@suse.de>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 2007-09-25 at 18:21 +0200, Matthias Koenig wrote:
> Hi,
> 
> we noticed a problem concerning loop mounts on locations that 
> have to be mounted before. E.g. consider the following situation,
> a NFS server exporting a cd image, which we want to loop mount
> locally to get access to the content:
> 
> auto.master:
> /cdimage        auto.cdimage
> /cdcontent      auto.cdcontent
> 
> auto.cdimage:
> foo             nfsserver:/cdimage/foo.img
> 
> auto.cdcontent:
> foo             -fstype=auto,loop       :/cdimage/foo/foo.img
> 
> The access to /cdcontent/foo will fail, when /cdimage/foo is not 
> mounted before, because spawn_mount does not use SPAWN_OPT_ACCESS
> in this case.

This test case seems broken to me.
Can you check you've described this correctly please.
Maybe even try this exact setup yourself.

Even if the maps were correct the procedure you describe wouldn't call
spawn_mount first, it would call spawn_bind_mount, which would then
trigger the mount through the access call.

Ian
