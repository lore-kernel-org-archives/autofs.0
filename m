From: Ian Kent <raven@themaw.net>
Subject: Re: autofs mounts drives that should not be mounted.
Date: Wed, 20 Sep 2006 23:25:12 +0800
Message-ID: <1158765912.19382.42.camel@raven.themaw.net>
References: <loom.20060920T144018-489@post.gmane.org>
	<loom.20060920T152128-874@post.gmane.org>
	<1158762835.19382.37.camel@raven.themaw.net>
	<loom.20060920T165402-267@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <loom.20060920T165402-267@post.gmane.org>
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
To: jack snodgrass <mylinuxguy+autofs@gmail.com>
Cc: autofs@linux.kernel.org

On Wed, 2006-09-20 at 15:00 +0000, jack snodgrass wrote:
> Ian Kent <raven <at> themaw.net> writes:
> 
> 
> > Don't think so.
> > Do you have any monitoring on this box.
> > I've had situations where health monitoring (network monitoring believe
> > it or not) was scanning directories.
> > 
> > Do you have hal installed?
> > What version is it?
> > 
> > Does the problem go away if you do a
> > /etc/init.d/hald stop
> > 
> > Basically we need to find out what is causing accesses to the
> > filesystems.
> > 
> > Ian
> > 
> 
> There are two issues... I should not have mentioned the 15 minute 
> thing.... the first / main issue was posted in my first message 
> today... you'll see i tested this on a stand-a-lone box and I 
> mounted /opt ( which was not part of my autofs stuff ) and all 
> of my autofs mounts were mounted.  ... I did a bit more checking
> and there is a symbolic link on /opt: 
> /opt/store/link_to_autofs_fs_directory
> that would ( maybe ) explain why one of the autofs mounts gets
> mounted when I mount /opt. It doesn't explain why ALL of the autofs
> mounts occur. 

Yep. That will certainly mount /myth/store, as it should, but I don't
know why the other mounts are being mounted.

I don't have any other similar reports and the autofs version you are
using has been current for quite a while now.

As for the kernel, the autofs4 stuff in it has also been there for quite
a while.

I'll have a go at trying to reproduce it as soon as I get some time.
Sorry I can't be more helpful.

Ian
