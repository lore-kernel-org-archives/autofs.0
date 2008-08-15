From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Re: Automounter losing track of mounts...
Date: Fri, 15 Aug 2008 10:13:42 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC70187A58DE@hqemmail01.nvidia.com>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A58BD@hqemmail01.nvidia.com>
	<48A33032.1060506@aei.mpg.de>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58CA@hqemmail01.nvidia.com>
	<48A555F9.1020808@s3group.cz>
	<1218800668.12073.3.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1218800668.12073.3.camel@raven.themaw.net>
Content-class: urn:content-classes:message
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
To: Ian Kent <raven@themaw.net>, Ondrej Valousek <webserv@s3group.cz>
Cc: autofs@linux.kernel.org

> -----Original Message-----
> From: Ian Kent [mailto:raven@themaw.net] 
> Sent: Friday, August 15, 2008 4:44 AM
> To: Ondrej Valousek
> Cc: Stephen Biggs; autofs@linux.kernel.org
> Subject: Re: [autofs] Automounter losing track of mounts...
> 
> 
> On Fri, 2008-08-15 at 12:10 +0200, Ondrej Valousek wrote:
> > >> We had a related issue quite a bit and /etc/mtab and 
> /proc/mounts 
> > >> went out of sync. Right now we are symlinking /etc/mtab to 
> > >> /proc/mounts. It works, but I don't know if that's the best 
> > >> solution for it.
> > >>     
> > >
> > > Yes, we could do that and that seems to be a canonical 
> solution that 
> > > is even talked about in the 'man' pages.  But, there may be a 
> > > problem with that.
> > >
> > > Have you seen any cases where different processes are 
> specifically 
> > > writing either to /etc/mtab _or_ /proc/mounts in an 
> asynchronous manner?
> > > Since it would now be the same file due to it being 
> symlinked, what 
> > > would that sort of write access do to the integrity of 
> the mount tables?
> > > Would it even matter?
> > >
> > >   
> > 1. You can not write to /proc/mounts as it is read only 2. 
> mount.nfs 
> > is broken (bug already filed) the way that it can not 
> handle symlink 
> > /etc/mtab -> /proc/mounts properly.
> > 3. I believe content handling of /proc/mounts is the 
> kernel's job. If 
> > it does not do it well, it should be patched -> we should not patch 
> > automounter as it is not its responsibility. The similar with 
> > /etc/mtab
> > - it is the mount responsibility to handle it.
> 
> That's right.
> 
> We do have a patch to check if /etc/mtab is a symlink to 
> /proc/mounts and use the "-n" option with mount(8) if it is 
> as mount(8) returns a fail (error is failed to update mtab, 
> surprise, surprise) if we don't.

Where can I get this patch?

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
