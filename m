From: Alexander Ponomarenko <apon@isd.dp.ua>
Subject: Re: autofs unmount don't work with symbolic links
Date: Tue, 02 Nov 2004 11:21:48 +0200
Message-ID: <1099387308.2199.28.camel@IAPonomarenko.isd.dp.ua>
References: <1098779618.19050.61.camel@IAPonomarenko.isd.dp.ua>
	 <200410302317.04738.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1099300553.19050.241.camel@IAPonomarenko.isd.dp.ua>
	 <200411011332.06171.vda@port.imtp.ilyichevsk.odessa.ua>
	 <Pine.LNX.4.58.0411020719151.7571@wombat.indigo.net.au>
Reply-To: apon@isd.dp.ua
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============96650214734532103=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411020719151.7571@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


--===============96650214734532103==
Content-Type: multipart/alternative; boundary="=-pZoBf3T5trH2jYtZ3Pmt"


--=-pZoBf3T5trH2jYtZ3Pmt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On 02 November 2004, Ian Kent wrote:

> On Mon, 1 Nov 2004, Denis Vlasenko wrote:
> 
> > Please use "reply before quote" style.
> > 
> > On Monday 01 November 2004 11:15, Alexander Ponomarenko wrote:
> > > I use Debian Linux (testing) and version of automount there is
> > >         Linux automount version 4.0.0
> > > But I think this bug is not known and so is not fixed yet even in new
> > > versions (I didn't find any subject on this question in Internet).
> > 
> > I can confirm that bug is still there in 4.1.3:
> > 
> > # automount /mnt/auto
> > 
> > (/mnt is a symlink) does not expire mounts:
> > 
> > 13:23:47 * Initializing
> > 13:23:48 * Starting: automount -f -s -v --timeout 15 /mnt/auto program /root/bin/mapper.sh
> > 13:23:48 starting automounter version 4.1.3, path = /mnt/auto, maptype = program, mapname = /root/bin/mapper.sh
> > 13:23:48 using kernel protocol version 3.00
> 
> Does this occur with the autofs4 module.
> We want to see 4.05 instead of 3.00.


I saw the same with autofs (3) and autofs4 modules.

/etc/auto.master is

/var/autofs/local       /etc/auto.local         --timeout=30
/usr/var/autofs/remote  /etc/auto.remote        --timeout=300
/usr/var/autofs/mks     /etc/auto.mks           --timeout=300

where /var is simbolic link to /usr/var. All mounts from /etc/auto.local
don't unmounts on expiration time but mounts from /etc/auto.remote and
/etc/auto.mks works fine (unmounts on expiration time). The situation is
the same as for the version 3 of autofs kernel module, as for the
version 4. I can add syslog logs if needed (too mach for posting).


--
Alexander Ponomarenko
ISD Configuration Management Team
E-mail: apon@isd.dp.ua

--=-pZoBf3T5trH2jYtZ3Pmt
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
On <FONT SIZE="3">02 November 2</FONT>004, Ian Kent wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#416ea5"><I>On Mon, 1 Nov 2004, Denis Vlasenko wrote:

&gt; Please use &quot;reply before quote&quot; style.
&gt; 
&gt; On Monday 01 November 2004 11:15, Alexander Ponomarenko wrote:
&gt; &gt; I use Debian Linux (testing) and version of automount there is
&gt; &gt;         Linux automount version 4.0.0
&gt; &gt; But I think this bug is not known and so is not fixed yet even in new
&gt; &gt; versions (I didn't find any subject on this question in Internet).
&gt; 
&gt; I can confirm that bug is still there in 4.1.3:
&gt; 
&gt; # automount /mnt/auto
&gt; 
&gt; (/mnt is a symlink) does not expire mounts:
&gt; 
&gt; 13:23:47 * Initializing
&gt; 13:23:48 * Starting: automount -f -s -v --timeout 15 /mnt/auto program /root/bin/mapper.sh
&gt; 13:23:48 starting automounter version 4.1.3, path = /mnt/auto, maptype = program, mapname = /root/bin/mapper.sh
&gt; 13:23:48 using kernel protocol version 3.00

Does this occur with the autofs4 module.
We want to see 4.05 instead of 3.00.</I></FONT></PRE>
</BLOCKQUOTE>
<BR>
I saw the same with autofs (3) and autofs4 modules.<BR>
<BR>
/etc/auto.master is<BR>
<BR>
<TT>/var/autofs/local&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /etc/auto.local&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --timeout=30<BR>
/usr/var/autofs/remote&nbsp; /etc/auto.remote&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --timeout=300<BR>
/usr/var/autofs/mks&nbsp;&nbsp;&nbsp;&nbsp; /etc/auto.mks&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --timeout=300</TT><BR>
<BR>
where /var is simbolic link to /usr/var. All mounts from /etc/auto.local don't unmounts on expiration time but mounts from /etc/auto.remote and /etc/auto.mks works fine (unmounts on expiration time). The situation is the same as for the version 3 of autofs kernel module, as for the version 4. I can add syslog logs if needed (too mach for posting).<BR>
<BR>
<PRE><TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
--<BR>
Alexander Ponomarenko<BR>
ISD Configuration Management Team<BR>
E-mail: apon@isd.dp.ua
</TD>
</TR>
</TABLE>
</PRE>
</BODY>
</HTML>

--=-pZoBf3T5trH2jYtZ3Pmt--


--===============96650214734532103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============96650214734532103==--

