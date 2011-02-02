From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5.0.5 patches for old kernels.
Date: Wed, 02 Feb 2011 21:23:59 +0800
Message-ID: <1296653039.2788.10.camel@perseus>
References: <3138.10.16.10.158.1296575501.squirrel@mail.serc.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=DqgyX9FEUeyfi73T79j7zG9MCOY=;
	b=lukZb3Qx8H1IuGkvMH14TqkN+E4u3qZUVPRsmS7eFUTguW1NYZrVGOswZomIwi9Zj2RoMH0+7Gjx7HowCfAIkRrMKjVATxf19PfmDcf1XobaXGv01ephTyfPHEFM7gHMe1OmadE6qKoHzPeWR87LBT6BRblDqLH+iKs6l1ZbjIA=
In-Reply-To: <3138.10.16.10.158.1296575501.squirrel@mail.serc.iisc.ernet.in>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: kiran@serc.iisc.ernet.in
Cc: autofs@linux.kernel.org

On Tue, 2011-02-01 at 21:21 +0530, kiran@serc.iisc.ernet.in wrote:
> Hi,
> 
>  In autofs-5.0.5 distribution there are no kernel V5 patches for old
> kernel(s2.6.9 to 2.6.17), but document INSTALL says
> 
> 
> ====================
> Applying The Kernel Patch
> =========================
> 
> Patches that can be applied to the kernel are located in the
> `patches' directory. If you have installed autofs from an rpm
> then they can be found in the packages' doc directory after
> install. They consist of a kernel patch for each kernel from
> 2.6.9 thru 2.6.16 (the patches are in the 2.6.17-rc series so
> patching a 2.6.17 or above kernel shouldn't be needed).
> =================================================
> 
> Where can we find patchs for old kernels?

There aren't any.

As changes have accumulated back porting the patches has become more and
more difficult due to changes in other parts of the kernel. So I had to
stop back porting them, especially since I can't properly test them.
  
> v5.0.5 is it not support on old kernels ?

2.6.18 is an old kernel.

You can use the patches from older v5 source tarballs and report any
problems but if you use autofs heavily you probably should be using a
more recent kernel. There are back ports of the patch series in those
tars. You won't get the new device ioctl interface changes (that was
about the time I had to stop) but autofs will know the kernel doesn't
have this and use the old ioctl interface.

I could spend a little time having a look at what I have but not for a
while yet. What problem are you trying to resolve exactly.

> 
> Thanking you,
> regards,
> kiran
> 
> 
> 
> 
> 
> 
> 
