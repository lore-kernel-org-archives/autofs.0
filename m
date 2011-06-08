From: Ian Kent <raven@themaw.net>
Subject: Re: failed to mount offset
Date: Wed, 08 Jun 2011 21:17:35 +0800
Message-ID: <1307539055.3275.64.camel@perseus.themaw.net>
References: <BANLkTinFxOHK1NMJfBy5bjHMpozM8oY9kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=NTXEV3DEzydXmsFkPoHCCv8zXAE=;
	b=sr97pY1MASCGYuSO2chyNAx6lg2UvalhZwoPmsvcFC7Wxnpvcc/fqP/NbjgHgmqB+A1XoM3LibUBVh4P9QlUptXtOfmkZb0osa0fpzOH00MeR+y4ZUnE9W53ccEN9ZmlfbFUEJmJn5GGabvWRvgN32falqp3+DCJjrWiUSYytFg=
In-Reply-To: <BANLkTinFxOHK1NMJfBy5bjHMpozM8oY9kg@mail.gmail.com>
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
To: Mag Gam <magawake@gmail.com>
Cc: autofs@linux.kernel.org

On Wed, 2011-06-08 at 05:06 -0500, Mag Gam wrote:
> Hello
> Trying to mount a newly created volume on a fileserver (appliance) and
> nis. Able to see the volume using showmount and able to mount so, I
> don't believe its a permission problem.
> 
> The error I get is,
> 
> -zsh: cd: /net/appliance/newvol No such file or directory

I'm guessing you are using the hosts map?

You will get that until the mount tree under /net/appliance expires away
so the exported entries can be updated. The exported entries can't be
sanely updated while the mount tree under the server directory is being
used since export list can be hierarchical and so can have order of
mount/umount dependencies.

> 
> kernel version:
> 2.6.18-238.el5
> 
> 
> autofs version
> autofs-5.0.1-0.rc2.143.el5_5.6.x86_64
> Running RHEL 5.6 (Enterprise edition)
> 
> 
> Autofs is in debugging mode but does not show up anything.
> 
> 
> After I restart autofs many times I only see this message in syslog
> (debugging enabled):
> mount_multi_triggers: mount offset /net/appliancev/newvol at /net/appliance
> failed to mount offset

At this point autofs is probably completely confused as it tries to
reconstruct the tree of mounts under /net/appliance. That message is
usually a unpleasant sign that things are messed up. About the only
thing that is worth doing is a postmortem analysis to see if there is
anything that can be changed to make automount more tolerant.

Ian
