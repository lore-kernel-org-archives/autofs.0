From: Alexander Ponomarenko <apon@isd.dp.ua>
Subject: Re: autofs unmount don't work with symbolic links
Date: Mon, 01 Nov 2004 11:15:53 +0200
Message-ID: <1099300553.19050.241.camel@IAPonomarenko.isd.dp.ua>
References: <1098779618.19050.61.camel@IAPonomarenko.isd.dp.ua>
	 <200410302317.04738.vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: apon@isd.dp.ua
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============59655738354182875=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200410302317.04738.vda@port.imtp.ilyichevsk.odessa.ua>
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
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: autofs@linux.kernel.org


--===============59655738354182875==
Content-Type: multipart/alternative; boundary="=-Y3bW6YY6BkgR5H9fWo8a"


--=-Y3bW6YY6BkgR5H9fWo8a
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I use Debian Linux (testing) and version of automount there is
        Linux automount version 4.0.0
But I think this bug is not known and so is not fixed yet even in new
versions (I didn't find any subject on this question in Internet).

On 30.10.2004 23:17, Denis Vlasenko wrote:

> On Tuesday 26 October 2004 11:33, Alexander Ponomarenko wrote:
> >     Hello!
> >     I found the trouble when I tryed to use autofs on linked var
> > filesystem. My /var is simbolic link to /usr/var. My filesystems
> > successfully mounts but didn't unmounts on expiration time.
> >     If I use full path in config files (/uar/var/autofs not simply
> > /var/autofs) all is OK.
> > 
> >     My operating system is Debian GNU/Linux:
> >         Linux IAPonomarenko 2.6.6-asp #1 Fri Jul 2 11:52:26 EEST 2004
> > i686 GNU/Linux.
> > 
> >     I think this information may be usefull for other people.
> 
> I saw the same on 4.0.0pre10. I worked around by substituting
> the path symlink points to.
> 
> I didn't check this on 4.1.3 (forgot about the issue)
> 
> Which version is yours?
> --
> vda

--
Alexander Ponomarenko
ISD Configuration Management Team
E-mail: apon@isd.dp.ua

--=-Y3bW6YY6BkgR5H9fWo8a
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
I use Debian Linux (testing) and version of automount there is<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Linux automount version 4.0.0<BR>
But I think this bug is not known and so is not fixed yet even in new versions (I didn't find any subject on this question in Internet).<BR>
<BR>
On 30.10.2004 23:17, Denis Vlasenko wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#416ea5"><I>On Tuesday 26 October 2004 11:33, Alexander Ponomarenko wrote:
&gt;     Hello!
&gt;     I found the trouble when I tryed to use autofs on linked var
&gt; filesystem. My /var is simbolic link to /usr/var. My filesystems
&gt; successfully mounts but didn't unmounts on expiration time.
&gt;     If I use full path in config files (/uar/var/autofs not simply
&gt; /var/autofs) all is OK.
&gt; 
&gt;     My operating system is Debian GNU/Linux:
&gt;         Linux IAPonomarenko 2.6.6-asp #1 Fri Jul 2 11:52:26 EEST 2004
&gt; i686 GNU/Linux.
&gt; 
&gt;     I think this information may be usefull for other people.

I saw the same on 4.0.0pre10. I worked around by substituting
the path symlink points to.

I didn't check this on 4.1.3 (forgot about the issue)

Which version is yours?
--
vda</I></FONT></PRE>
</BLOCKQUOTE>
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

--=-Y3bW6YY6BkgR5H9fWo8a--


--===============59655738354182875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============59655738354182875==--

