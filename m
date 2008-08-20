From: Thanh Tran <ttran7700@yahoo.com>
Subject: Re: Is Autofs 5 Slower Than 4
Date: Wed, 20 Aug 2008 08:00:12 -0700 (PDT)
Message-ID: <241046.64511.qm@web54306.mail.re2.yahoo.com>
References: <x49hc9fye3b.fsf@segfault.boston.devel.redhat.com>
Reply-To: ttran7700@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49hc9fye3b.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

I upgraded my entire OS from Fedora 5 to 8.  By slow, I mean around 20 seconds to detect and mount.  There are too many variables.  I was hoping it would be a simple polling flag that could be switched in autofs.  I can live with the slower time.  I did notice that it took a long time only when I physically removed the drive and re-inserted the drive.  When I use the "umount" command and not remove the drive, I can quickly change directory back to drive and it mounts in like 2 seconds at most.  Thanks for the help.  


--- On Wed, 8/20/08, Jeff Moyer <jmoyer@redhat.com> wrote:

> From: Jeff Moyer <jmoyer@redhat.com>
> Subject: Re: [autofs] Is Autofs 5 Slower Than 4
> To: ttran7700@yahoo.com
> Cc: autofs@linux.kernel.org
> Date: Wednesday, August 20, 2008, 10:07 AM
> Thanh Tran <ttran7700@yahoo.com> writes:
> 
> > The Autofs automounting was never blazing fast. 
> However, autofs 5
> > seems much slower than the previous version.  It takes
> a long time for
> > autofs to mount my detachable drives.  It eventually
> happens; it just
> > takes a long time.  Is there a way to improve this
> speed?  Thanks.
> 
> Could you quantify this?  What exactly are you doing?  Are
> you sure
> autofs is the cause of the sluggishness?  Did you upgrade
> your entire
> operating system or just autofs from version 4 to 5?  Can
> you provide a
> debug log?
> 
> Cheers,
> 
> Jeff
