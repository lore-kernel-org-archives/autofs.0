From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: 5.0.5 non-expiring mounts
Date: Mon, 14 Feb 2011 17:10:38 -0800
Message-ID: <20110215011037.GT27735@sunapee.qualcomm.com>
References: <4D510D53.7010507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=qualcomm.com; i=mmarion@qualcomm.com; q=dns/txt;
	s=qcdkim; t=1297737455; x=1329273455;
	h=x-authentication-warning:date:from:to:subject:message-id:
	references:mime-version:content-type:content-disposition:
	in-reply-to:x-operating-system:x-distribution:user-agent;
	z=X-Authentication-Warning:=20sunapee.qualcomm.com:=20mmar
	ion=20set=20sender=20to=20mmarion@qualcomm.com=20using=20
	-f|Date:=20Mon,=2014=20Feb=202011=2017:10:38=20-0800
	|From:=20Mike=20Marion=20<mmarion@qualcomm.com>|To:=20"au
	tofs@linux.kernel.org"=20<autofs@linux.kernel.org>
	|Subject:=20Re:=20[autofs]=205.0.5=20non-expiring=20mount
	s|Message-ID:=20<20110215011037.GT27735@sunapee.qualcomm.
	com>|References:=20<4D510D53.7010507@gmail.com>
	|MIME-Version:=201.0|Content-Type:=20text/plain=3B=20char
	set=3Dus-ascii|Content-Disposition:=20inline|In-Reply-To:
	=20<4D51 
Content-Disposition: inline
In-Reply-To: <4D510D53.7010507@gmail.com>
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Tue, Feb 08, 2011 at 01:30:59AM -0800, Philip Ong Jr. wrote:

> I've set the logging level to debug and can see messages of expiring 
> mounts in /var/log/messages...but when I check /etc/mtab or /proc/mounts 
> or df, i can still see them there. Any ideas if this is a known issue or 
> if I can give more info than below?

Out of curiosity... are these direct or indirect mounts?  We're seeing an
issue where our huge maps served from LDAP are seeing indirects not umounting
while logging expires just fine, but the direct maps are working great.  I
believe a co-worker has replicated this exact same behavior with local files
based maps too though, so pretty sure it's not really related to LDAP at all,
but we've found using LDAP helped clear out a lot of old issues we had a few
years ago related to the hashing bits.

I've even done network sniffing while doing a kill -USR1 and the automount
daemon opens new sockets for each indirect (our homedirs) path it wants to
expire, but there never is any actual network traffic sent across the wire.
Even better, the sockets stay stuck in ESTABLISHED for a long time.  Some more
USR1/expires and/or HUPs can help clear is, or I just run a script that does
an fuser then umount on unused homedirs and that flushes the ports out.  When
the ports pile up to >300 or so, you start getting NFS failures with syslog
showing "couldn't read superblock."

Oh, and when I say huge maps.. I mean it.  We're >10k direct mounts and I don't
know how many indirect mounts, but it's even more then that.

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
Antonio: "It's no fair.  Some men drink deep from the fountain of life, while
Antonio takes one sip and it goes down the wrong pipe!"
