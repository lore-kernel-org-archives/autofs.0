From: Ian Kent <raven@themaw.net>
Subject: Re: Automounter losing track of mounts...
Date: Fri, 15 Aug 2008 11:15:55 +0800
Message-ID: <1218770156.3152.3.camel@raven.themaw.net>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A58BD@hqemmail01.nvidia.com>
	<1218691003.27280.92.camel@raven.themaw.net>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58C9@hqemmail01.nvidia.com>
	<1218735745.3216.13.camel@raven.themaw.net>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58CF@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <A2ECBF49F352C24F9DF65BB529DCBC70187A58CF@hqemmail01.nvidia.com>
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
To: Stephen Biggs <sbiggs@nvidia.com>
Cc: autofs@linux.kernel.org


On Thu, 2008-08-14 at 11:14 -0700, Stephen Biggs wrote:
> > -----Original Message-----
> > From: Ian Kent [mailto:raven@themaw.net] 
> > Sent: Thursday, August 14, 2008 10:42 AM
> > To: Stephen Biggs
> > Cc: autofs@linux.kernel.org
> > Subject: RE: [autofs] Automounter losing track of mounts...
> > 
> 
> -- snip --
> 
> > > Perhaps. It could even be a bug in the mount userland 
> > software. But, 
> > > in any case, the automounter should handle this correctly and not 
> > > update its tables if the mount doesn't succeed for any reason. That 
> > > seems to be the real problem here.
> > 
> > What tables?
> > Keeping the mtab up to date in mounts' job not autofs.
> 
> Yes, it is. I apologize for my vagueness. I was talking about the
> autofs's internal lists (tables?) of mounts that it must create and
> maintain.
> 
> It looks like some sort of sequence where the first regular mount fails
> due to this mtab issue. When 'mount -f' is invoked and succeeds, the O/S
> mounts this directory but the automounter fails to update its lists to
> keep this as mounted and also deletes the mount point directory
> internally as well as on the autofs filesystem.
> 
> So what we have is the O/S and NFS thinking this particular export is
> mounted but the automounter doesn't, and there is no mount point because
> the automounter deletes the directory and any subsequent expire or 'df'
> fails.  The least intrusive fix for this situation is 'umount -a'.
> 
> This looks like a definite, albeit relatively minor, bug in the autofs
> daemon.
> 
> I actually misspoke above.  The problem here is the exact opposite of
> what I said above previously.  The automount fails to update its
> internal lists/tables to show a mounted directory even if the second
> mount attempt with '-f' succeeds.  It acts like it is in complete
> failure mode and also deletes the mount point out from underneath the
> mounted export.

Your jumping from a "this might be" to a "to solve this" without a
definite "this is caused by". You can't do that and expect it to be
resolved.
 
Ian
