From: Ian Kent <raven@themaw.net>
Subject: Re: Mounting a usb flash drive on /mnt
Date: Fri, 20 Apr 2007 15:11:15 +0800
Message-ID: <1177053076.3934.67.camel@raven.themaw.net>
References: <20070419181221.73C51160C1@l0ca1h0st.com>
	<1177045099.3934.56.camel@raven.themaw.net>
	<20070420051512.9782B3DFC3@l0ca1h0st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070420051512.9782B3DFC3@l0ca1h0st.com>
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
To: Derek Reid <autofs-ml@l0ca1h0st.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-04-19 at 23:15 -0600, Derek Reid wrote:
> Thanks for the reply, Ian.
> 
> Here are the details.  I need to mount my usb flash drive on /mnt/ .
> There is no problem mounting it at least two dirs deep (/mnt/foo/ for
> example) but you can't put "/" as the key in auto.master as "/" is
> already mounted.  Which leaves the other config file (auto.usb in my
> case).  It won't accept "/", which would then indicate "/mnt/", and it
> errors with the previously mentioned message.
> 
> I'm not sure if that helps explain my goal any more clearly but to
> answer your questions:
> 
> * autofs version:
> 
>   4.1.4 (Fedora Core 5 rpm)
> 
> * /etc/auto.master:  
> 
>   /mnt  /etc/auto.usb --timeout=3 --ghost  
> 
> * /etc/auto.usb: 
> 
>   /             -fstype=auto            :/dev/sdb1
> 
> In short, I suppose I can sum it up in one question:  How can you
> automount something exactly one directory deep from "/"?

OK, I get it.

The only way to do that (exactly one level) is to use a direct mount
map. This will only work with autofs version 5 with a kernel which
supports it. Version 5 won't start if the kernel doesn't support it.

In auto.master put

/-	/etc/auto.usb  --timeout=3

The "--ghost" option isn't needed.

In /etc/auto.usb put

/mnt	-fstype=auto	:/dev/sdb1

and that should do what you want.

> 
> Thanks,
> 
> Derek
> 
> On Fri, 2007-04-20 at 12:58 +0800, Ian Kent wrote:
> > On Thu, 2007-04-19 at 12:12 -0600, Derek Reid wrote:
> > > Hi,
> > > 
> > > I'd like to mount my usb flash drive exclusively on /mnt but I'm not
> > > sure if this is possible.
> > > 
> > > >From the docs, it looks like /etc/auto.master has to have /mnt listed as
> > > the key but in the usb autofs config, but I don't know what would need
> > > to be listed.  I've tried "/" and "." but neither seem to take.  I get
> > > the following message written to the syslog:
> > > 
> > > automount[21234]: bad map format: found indirect, expected direct
> > > exiting
> > > 
> > > Does anyone know if this *is* possible and if so, what do I need to put
> > > as the key?
> > 
> > No idea what you mean.
> > What version of autofs?
> > How about an example of what you're attempting to do with a description
> > of what you've done and what you've put in what files.
> > 
> > Ian
> > 
> > 
