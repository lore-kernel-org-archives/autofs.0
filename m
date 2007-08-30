From: Ian Kent <raven@themaw.net>
Subject: Re: regression of autofs for current git?
Date: Thu, 30 Aug 2007 11:00:04 +0800
Message-ID: <1188442804.4090.10.camel@raven.themaw.net>
References: <00f401c7ea7f$6db9fc80$492df580$@com>
	 <20070829224754.GW26410@stusta.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757834AbXH3DA0@vger.kernel.org>
In-Reply-To: <20070829224754.GW26410@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hua Zhong <hzhong@gmail.com>
Cc: 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org, Adrian Bunk <bunk@kernel.org>

On Thu, 2007-08-30 at 00:47 +0200, Adrian Bunk wrote:
> On Wed, Aug 29, 2007 at 01:58:58PM -0700, Hua Zhong wrote:
> 
> > Hi,
> 
> Hi Hua,
> 
> > I am wondering if this is a known issue, but I just built the current git
> > and several autofs mounts mysteriously disappeared. Restarting autofs could
> > fix some, but then lose others. 2.6.22 was fine.
> > 
> > Is there anything I could check other than bisect? (It may take some time
> > for me to get to it)
> 
> the commit below is the only autofs4 patch that went into the git tree 
> since 2.6.22.
> 
> Does reverting it fix your problems?

Maybe but there is an NFS change that appears to be in the current
2.6.23-rc kernel and doesn't seem to be in 2.6.22 that is known to break
some autofs maps and also breaks amd.

I can't seem to locate the commit just now.
In the meantime what version of user space autofs and nfs-utils are you
running?
And can you post your autofs maps please?

Ian



