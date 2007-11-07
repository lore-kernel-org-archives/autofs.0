From: Ian Kent <raven@themaw.net>
Subject: Re: automount deletes and fails to recreate mount points
Date: Wed, 07 Nov 2007 12:10:20 +0900
Message-ID: <1194405020.3113.8.camel@raven.themaw.net>
References: <0E22C564-0BD1-4930-889E-CBB4EBF05C52@leerssen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <0E22C564-0BD1-4930-889E-CBB4EBF05C52@leerssen.com>
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
To: Scott Leerssen <scott@leerssen.com>
Cc: autofs@linux.kernel.org

On Mon, 2007-11-05 at 12:43 -0500, Scott Leerssen wrote:
> Hi, 
> 
> 
> A google search and scan of the archives didn't reveal an answer, so I
> apologize in advance if this subject has been beaten to death
> already.  Here are a few version numbers for reference:
> 
> 
> CentOS 5
> kernel:  2.6.18-8.1.15.el5
> autofs: autofs-5.0.1-0.rc2.43.0.2
> SElinux: disabled
> 
> 
> I have a stock, yum updated CentOS 5 installation on which autofs
> works fine as long as the mount points are pre-existing.  However, if
> I stop the automounter with 'service autofs stop' (or by rebooting),
> the automounter deletes my /net and /misc mount points and then fails
> to recreate them on 'service autofs start'.
> 
> 
> One caveat to the "normal" CentOS 5 install, is that I'm running off
> of an NFS root.  Is there anything in particular about having a mount
> point inside another NFS mounted directory that would make automount
> want to remove my mount points and fail to recreate them?  

Yes.
Does pre-creating them within the NFS mounted root work OK?

Ian
