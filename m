From: Ian Kent <raven@themaw.net>
Subject: Re: Modified auto.smb script
Date: Mon, 03 Nov 2008 11:02:07 +0900
Message-ID: <1225677727.2911.17.camel@zeus.themaw.net>
References: <200810241646.56647.stef@bononline.nl>
	<1225116020.2990.33.camel@zeus.themaw.net>
	<200810291109.01097.stef@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200810291109.01097.stef@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

On Wed, 2008-10-29 at 11:09 +0100, Stef Bon wrote:
> On Monday 27 October 2008 15:00:20 Ian Kent wrote:
> > On Fri, 2008-10-24 at 16:46 +0200, Stef Bon wrote:
> > > Hi,
> > >
> > >
> > >
> > > I've sent this email before. Can you confirm it's arrived?
> >
> > Yeah, I've received your mail.
> > What do you want me to do with the script?

OK, finally back to this.

> >
> Well, the script does (in my network) work with cifs shares, where the
> original auto.smb doesn't. In my case I have to add the ipaddress or
> it does not work. The manpage of mount.cifs says that this option has
> to be used rarely. But it's my experience sometimes when mounting a
> Win2K or WinXP machine, it does not work.
> (CIFS expects the tcp name and not the netbiosname, smbfs did that)
> 
> 
> 
> So I cannot say it's a really "must", but at least it cannot "hurt".
> You're on the safe side when using the ipaddress.
> 
> 
> 
> Well I should add this script to the package autofs, replacing the
> auto.smb, if you want my opinion. 

But this isn't really the way to go about it.

Next time, you should really make a unified diff of the change and post
it to the autofs list for discussion.

I don't use CIFS mounts myself and have to rely on others, like
yourself, that do. Those that do should have an opportunity to see what
is being proposed and comment on its potential impact.

In any case, I think there are some other problems with our use of
delimiters and escape characters when using the latest kernels, which
cause mount fails, so I need to investigate that also.

> 
> 
> 
> Smbfs is not supported anymore in the latest kernels.
> 
> 
> 
> Stef
> 
> 
> 
> 
> 
> 
