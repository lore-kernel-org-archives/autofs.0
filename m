From: Ian Kent <raven@themaw.net>
Subject: Re: automount never umount
Date: Tue, 22 Nov 2005 08:27:01 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0511220822410.16196@wombat.indigo.net.au>
References: <4381E865.4070908@bppiac.hu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4381E865.4070908@bppiac.hu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Farkas Levente <lfarkas@bppiac.hu>
Cc: autofs@linux.kernel.org

On Mon, 21 Nov 2005, Farkas Levente wrote:

> hi,
> i'm just start autofs on my desktop machine. the main reason for this
> because smbfs (and also cifs) use a very high network load on my system
> and i use these file very seldom, so it'd be very useful if after a few
> minutes these fs can be umounted. unfortunately it seems that neither
> cifs or smbfs not nfs volumes are never umounted. if they mounted once
> they will remain there forever. it seems automount has the right option:
> --------------------------------
> root      2007  0.0  0.0   1792   696 ?        Ss   Nov16   0:00
> /usr/sbin/automount --timeout=60 /smb program /etc/auto.smb
> root      2041  0.0  0.0   1788   696 ?        Ss   Nov16   0:00
> /usr/sbin/automount --timeout=60 /net program /etc/auto.net
> --------------------------------
> i try to find out which file can hold /net or /smb but neither fuser nor
> lsof can show anything. is there any way to find out something about the
> status of automount? eg which files are used what is the timeout when
> the timeout fill be left etc?
> what can be wrong? any tip?
> my system is fedora core 4 full update:
> kernel-2.6.14-1.1637_FC4
> autofs-4.1.4-5
> nfs-utils-1.0.7-12.FC4
> samba-client-3.0.14a-2
> thank you for your help in advance.
> yours.

I see this sort of thing from time to time but I have always been 
unable to find out what is causing it.

Are you using a GUI. They are well known for scanning filesystems and 
keeping automounts active.

Maybe I need to alter the autofs definition of busy. I'll think about it.

Ian
