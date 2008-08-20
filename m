From: Thanh Tran <ttran7700@yahoo.com>
Subject: Re: Auto Unmount???
Date: Wed, 20 Aug 2008 08:20:47 -0700 (PDT)
Message-ID: <933512.68167.qm@web54307.mail.re2.yahoo.com>
References: <x49ljyrye57.fsf@segfault.boston.devel.redhat.com>
Reply-To: ttran7700@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49ljyrye57.fsf@segfault.boston.devel.redhat.com>
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

I did notice some timeout values in my sysconf/autofs.  I thought those flags set the amount of time autofs would try to mount something before giving up.  Which flag sets the timeout?  Perhaps, you mean the option flag?  Thanks.  


--- On Wed, 8/20/08, Jeff Moyer <jmoyer@redhat.com> wrote:

> From: Jeff Moyer <jmoyer@redhat.com>
> Subject: Re: [autofs] Auto Unmount???
> To: ttran7700@yahoo.com
> Cc: autofs@linux.kernel.org
> Date: Wednesday, August 20, 2008, 10:06 AM
> Thanh Tran <ttran7700@yahoo.com> writes:
> 
> > Is auto unmounting supported in autofs version 5?  If
> so, how do you set the timeout?
> 
> You can either set it per mount point or globally.  Per
> mount point
> requires a --timeout=X on the line for the mount point in
> the master
> map.  Globally, it can be set in /etc/sysconfig/autofs (on
> systems that
> use the sysconfig directory).
> 
> Cheers,
> 
> Jeff
