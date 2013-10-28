From: Ian Kent <raven@themaw.net>
Subject: Re: autofs not releasing mounts
Date: Mon, 28 Oct 2013 16:17:12 +0800
Message-ID: <1382948232.2523.20.camel@perseus.fritz.box>
References: <CANvHAxTfGZ9jXskeNJ2T_QXs3eY=VuxkSzLvrU8UKJTNr7SidA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=rm80WRXQFBwvQKtMJdo8Lp90wEQ=; b=u6OqCLJypNrr1AEWtli7+MyBgnNG
	JutHa1BYl9Q89rkTBscAB2mxYRoYXdAEka49jli48OT7LQcW1ZdL81Uh4SMschqN
	E1cJ1lZEEIzUMq9ucWno2n+FGzJyJ8sTy5wiuHUpJVv1S0NDcmvdbFFDnGyQs10A
	uJm69z48C25CQdY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=rm80WRXQFBwvQKtMJdo8Lp
	90wEQ=; b=bh1CMebAJF6rStEC2THbpVkafTsvNs2SgKtbJ0Y3W52iOAd4PG2kU2
	uqr1Bhaq44WjMjIwvuleD6IiWKfzQLeskYquxfdonNq+g56pqQh/wFmVtbVHEpc8
	1U4nz+rYj9+HWGa7QBrvK+nuU+ewkeh4LPkKZ7m3v6eCBG+5TShcA=
In-Reply-To: <CANvHAxTfGZ9jXskeNJ2T_QXs3eY=VuxkSzLvrU8UKJTNr7SidA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Colin Coe <colin.coe@gmail.com>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On Thu, 2013-10-24 at 11:17 +0800, Colin Coe wrote:
> Hi all
> 
> We are using a pair of Windows 2012 Servers to provide CIFS and NFS
> shares to a mix of Windows and RHEL clients.  These servers are
> geographically diverse and use DFS-R to replicate content.
> 
> I'm finding that the RHEL clients are not releasing the mounts after
> the 300 second time out specified in /etc/sysconfig/autofs.
> 
> I logged into a node and my home dir auto mounted.
> I logged out
> From the console where I logged in as root I ran 'lsof /home/myhome'
> and nothing was returned

Are you certain that nothing else is accessing the directory during the
timeout period?

The last used time stamp will be updated on any access, like Gnome file
system scanning or system monitoring utilities.

> From console tail -f /var/log/messages I see
> ---
> Oct 24 10:17:55 benadm1p automount[19980]: Starting automounter
> version 5.0.5-75.el6_4, master map auto.master
> Oct 24 10:17:55 benadm1p automount[19980]: using kernel protocol version 5.02
> Oct 24 10:17:55 benadm1p automount[19980]: mounted direct on
> /fileshare with timeout 300, freq 75 seconds
> Oct 24 10:17:55 benadm1p automount[19980]: mounted indirect on /home
> with timeout 300, freq 75 seconds
> Oct 24 10:17:55 benadm1p automount[19980]: ghosting enabled
> Oct 24 10:36:31 benadm1p automount[19980]: attempting to mount entry
> /home/h086629
> Oct 24 10:36:31 benadm1p automount[19980]: mount(nfs): mounted
> benfil2p:/home/h086629 on /home/h086629
> Oct 24 10:36:31 benadm1p automount[19980]: mounted /home/h086629
> Oct 24 10:37:12 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:38:27 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:39:42 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:40:57 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:42:12 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:43:27 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:44:42 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:45:57 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:47:12 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:48:27 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:49:11 benadm1p automount[19980]: attempting to mount entry /fileshare
> Oct 24 10:49:11 benadm1p automount[19980]: mount(nfs): mounted
> benfil2p:/fileshare on /fileshare
> Oct 24 10:49:11 benadm1p automount[19980]: mounted /fileshare
> Oct 24 10:49:36 benadm1p automount[19980]: 1 remaining in /-
> Oct 24 10:49:42 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:50:51 benadm1p automount[19980]: 1 remaining in /-
> Oct 24 10:50:57 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:52:06 benadm1p automount[19980]: 1 remaining in /-
> Oct 24 10:52:12 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:53:21 benadm1p automount[19980]: 1 remaining in /-
> Oct 24 10:53:27 benadm1p automount[19980]: 1 remaining in /home
> Oct 24 10:54:36 benadm1p automount[19980]: 1 remaining in /-
> Oct 24 10:54:42 benadm1p automount[19980]: 1 remaining in /home
> ---
> /etc/auto.master
> /-              /etc/auto.hp --ghost
> /home     /etc/auto.home --ghost
> 
> /etc/auto.hp
> /fileshare      -rw,vers=3,tcp,nolock benfil2p,karfil2p:/fileshare
> 
> /etc/auto.home
> *       -rw,vers=3,tcp,nolock        benfil2p,karfil2p::/home/&
> 
> /etc/sysconfig/autofs (with comment and blank lines stripped out)
> TIMEOUT=300
> BROWSE_MODE="no"
> MOUNT_NFS_DEFAULT_PROTOCOL=3
> LOGGING="verbose"
> USE_MISC_DEVICE="yes"
> 
> 
> Thanks in advance
> 
> CC
> 


