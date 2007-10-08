From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] nested mounts with loop
Date: Mon, 08 Oct 2007 11:49:54 +0800
Message-ID: <1191815394.3129.6.camel@raven.themaw.net>
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

Just trying to test this out and it seem that this should
read :/cdimage/foo.

Correct?

Ian
