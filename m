From: Ian Kent <raven@themaw.net>
Subject: Re: Question about timeout option.
Date: Sun, 27 Apr 2008 23:59:39 +0800
Message-ID: <1209311979.7913.37.camel@raven.themaw.net>
References: <48148A3A.5070303@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48148A3A.5070303@bononline.nl>
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


On Sun, 2008-04-27 at 16:14 +0200, Stef Bon wrote:
> Hello,
> 
> 22 april I posted a message with the question about the timeout option.
> 
> Has anybody read it, and possibly have a clue?

I read it.
Try using -browse or browse (not --browse).
It might prevent the top directories from being removed after expire
(and when you access these it will re-create the sub-directories each
time so that will be OK) but it wont be able to create the directories
initially because it's a program map and autofs doesn't have a way to
ask it for a list of it's keys. I haven't really had any suggestions
that I think are workable for doing this.

> 
> Basically explained: I'm using a multiple mounts map to mount the smb 
> shares and the ssh hosts.
> The key here is the name of the network. In the case of smb it's 
> "Windows Network", with ssh it's
> "SSH hosts".
> The autoscript mapped to the mountpoint produces with this key a map like:
> 
> /etc/autofs/session/auto.network.sbon "Windows Network"
> 
> -fstype=cifs,credentials=/home/sbon/.autofssession/smb/mount.cred \
>    /BONONLINE/LFS20060812/bononline -rw,ip=192.168.0.2 ://LFS20060812/bononline \
>    /BONONLINE/LFS20060812/ftp -rw,ip=192.168.0.2 ://LFS20060812/ftp \
>    /BONONLINE/LFS20060812/sbon -rw,ip=192.168.0.2 ://LFS20060812/sbon \
>    /BONONLINE/LFS20060812/video -rw,ip=192.168.0.2 ://LFS20060812/video \
>    /CWWERKGROEP/ROUTER/ftp -rw,ip=192.168.0.1 ://ROUTER/ftp \
>    /CWWERKGROEP/ROUTER/public -rw,ip=192.168.0.1 ://ROUTER/public \
>    /CWWERKGROEP/ROUTER/sbon -rw,ip=192.168.0.1 ://ROUTER/sbon
> 
> If the key is "SSH hosts" it't output is:
> 
> /etc/autofs/session/auto.network.sbon "SSH hosts"
> 
> -fstype=sshfs \
> /192.168.0.3 -rw,nodev,nonempty,noatime ://sbon@192.168.0.3:/ \
> /192.168.0.1 -rw,nodev,nonempty,noatime ://sbon@192.168.0.1:/ \
> /192.168.0.15 -rw,nodev,nonempty,noatime ://sbon@192.168.0.15:/ \
> /195.243.111.226 -rw,nodev,nonempty,noatime ://sbon@195.243.111.226:/ \
> /192.168.0.10 -rw,nodev,nonempty,noatime ://sbon@192.168.0.10:/ \
> /192.168.0.2 -rw,nodev,nonempty,noatime ://sbon@192.168.0.2:/
> 
> When starting the automounter I have to activate these maps by doing a 
> initial
> 
> ls %MOUNTPOINT%/"Windows Network"
> and
> ls %MOUNTPOINT%/"SSH hosts"
> 
> 
> Now I can browse the tree which is created. But when I leave it for a while,
> this tree will disappear. I have to do the ls commands like above again.
> 
> Now a can avoid this behaviour by diabling the timeout by adding the 
> --timeout 0
> option in the master file. But this has some disadvantages:
> - mounted shares/hosts are not unmounted anymore when not used for a 
> period set by the timeout option
> - the current map stays in memory. This means that changes in the 
> underlying network (a host is added for example)
> will not get their way into this map.
> 
> So, to stay with the first problem, has someone an idea how to solve 
> this "timeout" of the map. How can I make the automounter not "forget" 
> the map, but unmount shares that not used anymore?
> 
> Thanks in advance,
> 
> Stef Bon
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
