From: raven@themaw.net
Subject: Re: How to automount hidden Windows share
Date: Thu, 27 Jan 2005 20:22:35 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501272016470.8888@donald.themaw.net>
References: <41F8A365.8080808@volny.cz>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <41F8A365.8080808@volny.cz>
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
To: Milan Knizek <knizek@volny.cz>
Cc: autofs@linux.kernel.org

On Thu, 27 Jan 2005, Milan Knizek wrote:

> Hello,
>
> I am not sure if this relates to kernel or to autofs, so sorry if I am wrong. 
> I also tried to google for the problem, but I have found only questions and 
> no solution.
>
>
> I use autofs-4.1.3, gentoo-dev-sources kernel 2.6.9 compiled with automounter 
> v4 on Gentoo. I have problems with automounting hidden Windows shares - e.g. 
> my /etc/autofs/auto.work includes:
>
> n -fstype=smbfs,users,uid=knizek_m,gid=users,credentials=/etc/samba
        What's this^^^^^ 
> /credentials_argon ://ffile01/Home$
>
> My /etc/autofs/auto.master includes:
>
> /mnt/auto.work /etc/autofs/auto.work --timeout=60
>
>
> When try ls /mnt/auto.work/n, the file does not exist. Syslog reads:
>
> Jan 26 12:18:40 n1005 automount[10417]: failed to mount /mnt/auto.work/n
> Jan 26 12:18:40 n1005 automount[10420]: >> Usage: mount.smbfs service 
> mountpoint [-o options,...]
> Jan 26 12:18:40 n1005 automount[10420]: >> Version 3.0.9
>

I'd like to see the log entries prior to the "failed to mount" message 
with the --debug option on the entry in the master map please.

This looks like a parsing problem. But I would have expected escaping the 
$ to have worked.

> ... cut on purpose ...
>
> Jan 26 12:18:40 n1005 automount[10420]: mount(generic): failed to mount 
> "://ffile01/Home" (type smbfs) o
> n /mnt/auto.work/n
> Jan 26 12:18:40 n1005 automount[10420]: failed to mount /mnt/auto.work/n
>
>
> I tried to change the line in auto.work to ://ffile01/Home\$ but it did not 
> help anyway.
>
> When I use fstab or mount manually, it works. Also, mounting normal Windows 
> shares (not ending with $) and local devices like cdrom and usb works fine 
> with automount.
>
> Is there other way to go?
>
> Thanks,
> Milan
> knizek@volny.cz
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
