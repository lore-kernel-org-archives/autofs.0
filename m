From: raven@themaw.net
Subject: Re: autofs and terminal networks woes.
Date: Thu, 17 Feb 2005 21:39:32 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502172136030.1683@donald.themaw.net>
References: <215ff441050217023378003e72@mail.gmail.com>
Mime-Version: 1.0
In-Reply-To: <215ff441050217023378003e72@mail.gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Chris Fanning <christopher.fanning@gmail.com>
Cc: autofs@linux.kernel.org

On Thu, 17 Feb 2005, Chris Fanning wrote:

Versions?

>
> So I setup the samba server on the thinclient to accept guest without password
> (I read somewhere that this was necessary for autofs).

Probably because we don't have user credentials.

>
> more /etc/auto.terminals
> floppy  -fstype=smbfs,guest,fmask=666,dmask=777        ://a_thinclient_ip/fd
> and it works!
>
> However, I think I need to use an external script (you call that a
> map?) that produces this output
> a_thinclient_ip   -fstype=smbfs,guest,fmask=666,dmask=777
> /floppy thinclient_ip:/fd
>
> I have manually added this to auto.smb to test it and it doesn't work.
>
> So my question here is why?
> floppy  -fstype=smbfs,guest,fmask=666,dmask=777
> ://a_thinclient_ip/fd  (this mounts)
> a_thinclient_ip   -fstype=smbfs,guest,fmask=666,dmask=777
> /floppy thinclient_ip:/fd   (this doesn't)
           ^^^^^^^^^^^^^ Doesn't look like an smb name?

Perhaps you need to use ://thinclient_ip/fd
But then that will only work (I hope) with the 4.1.4 beta.

Ian
