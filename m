From: Rich Sahlender <rsahlen@voicenet.com>
Subject: Re: multiple servers per automount
Date: Wed, 8 Oct 2003 16:43:04 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20031008204304.GA4056@born2.midworld.org>
References: <20031008172451.GA1775@born2.midworld.org>
	<3F845E0C.7020801@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <3F845E0C.7020801@zytor.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org

On Wed, Oct 08, 2003 at 11:57:16AM -0700, H. Peter Anvin wrote:
> Rich Sahlender wrote:
> > This is probably a faq but I havn't seen it asked in recent months...
> > 
> > I have a situation where two network appliance filers with identical
> > file systems are used to serve read only mounts for CAD software tools.
> > Both Solaris and HP-UX support an automount like:
> > 
> > cadtool	-ro	tools1,tools2:/vol/vol1/tools/&
> > 
> > and will automatically switch to the other server if the initial mount
> > becomes unavailable.
> > 
> > Last time I was able to check Linux autofs did not support the failover
> > and complained about the syntax. Has this changed or are there plans to
> > support the syntax above with failover for read only mounts?
> > 
> 
> This should not be an autofs feature but an NFS feature, for obvious
> reasons: it's equally applicable for static mounts.
> 
> Furhtermore, failover HAS to be done at the NFS layer.
> 
> The fact that Slowlaris does it in autofs is not a good motivation --
> it's idiotic design.
> 
> 	-hpa

I disagree. These are read only mounts. How is it an idiotic design to
provide a little extra availability by switching to another server in the
list if the mounted server becomes unavailable?

Furthermore, the fact that it is equally applicable for static mounts
does not make it an obvious NFS issue. I submit it's both an NFS and an
autofs issue...
