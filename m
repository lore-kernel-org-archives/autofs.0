From: "Stephen C. Rigler" <srigler@marathonoil.com>
Subject: Re: autofs to load MAP from LDAP
Date: Thu, 09 Nov 2006 07:11:47 -0600
Message-ID: <1163077907.9612.18.camel@houuc8>
References: <29c5cd460611082119u63dcc765j56c58c07f6ccd072@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7872380987377030805=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <29c5cd460611082119u63dcc765j56c58c07f6ccd072@mail.gmail.com>
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
To: autofs@linux.kernel.org


--===============7872380987377030805==
Content-Type: multipart/alternative; boundary="=-Ed7UMYk0MBFdNi64cYVx"


--=-Ed7UMYk0MBFdNi64cYVx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-11-09 at 10:49 +0530, Syed Khader wrote:

> Hello Everybody,
> 
> How to make autofs read map from ldap rather than files.
> 


Syed,

We run a mixed environment of Irix, Solaris and Linux machines.  To keep
the Solaris machines happy, we use their schema (keys are "automountkey"
rather than "cn", etc).  With autofs-4, Linux needs a different master
map, but with version 5 it looks like we'll be able to use the same map
as the other platforms.

To point the Linux machines at your master map set "LDAPAUTOMASTER"
in /etc/sysconfig/autofs to the name of the map (the name, not the dn).

Our master map looks like:

dn: automountMapName=auto.master_linux,dc=example,dc=com
automountMapName: auto.master_linux
objectClass: top
objectClass: automountMap

dn:
automountkey=/home,automountmapname=auto.master_linux,dc=example,dc=com
objectClass: automount
objectClass: top
automountKey: /home
automountInformation: ldap:automountmapname=auto_home,dc=example,dc=com

auto_home looks like:

dn: automountMapName=auto_home,dc=example,dc=com
automountMapName: auto_home
objectClass: top
objectClass: automountMap

dn: automountkey=someuser,automountmapname=auto_home,dc=example,dc=com
objectClass: automount
objectClass: top
automountKey: someuser
automountInformation: -rw    server:/export/home/&

Hope this helps.

-Steve


--=-Ed7UMYk0MBFdNi64cYVx
Content-Type: text/html; charset=utf-8

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.3.2">
</HEAD>
<BODY>
On Thu, 2006-11-09 at 10:49 +0530, Syed Khader wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">Hello Everybody,</FONT><BR>
    <BR>
    <FONT COLOR="#000000">How to make autofs read map from ldap rather than files.</FONT><BR>
    <BR>
</BLOCKQUOTE>
<BR>
Syed,<BR>
<BR>
We run a mixed environment of Irix, Solaris and Linux machines.&nbsp; To keep the Solaris machines happy, we use their schema (keys are &quot;automountkey&quot; rather than &quot;cn&quot;, etc).&nbsp; With autofs-4, Linux needs a different master map, but with version 5 it looks like we'll be able to use the same map as the other platforms.<BR>
<BR>
To point the Linux machines at your master map set &quot;LDAPAUTOMASTER&quot; in /etc/sysconfig/autofs to the name of the map (the name, not the dn).<BR>
<BR>
Our master map looks like:<BR>
<BR>
<TT>dn: automountMapName=auto</TT>.<TT>master</TT>_linux<TT>,dc=example,dc=com</TT><BR>
<TT>automountMapName: auto</TT>.<TT>master</TT>_linux<BR>
<TT>objectClass: top</TT><BR>
<TT>objectClass: automountMap</TT><BR>
<BR>
<TT>dn: automountkey=/home,automountmapname=auto</TT>.master_linux<TT>,dc=example,dc=com</TT><BR>
<TT>objectClass: automount</TT><BR>
<TT>objectClass: top</TT><BR>
<TT>automountKey: /home</TT><BR>
<TT>automountInformation: </TT>ldap:automountmapname=auto_home,dc=example,dc=com<BR>
<BR>
<TT>auto_home looks like:</TT><BR>
<BR>
<TT>dn: automountMapName=auto_home,dc=example,dc=com</TT><BR>
<TT>automountMapName: auto_home</TT><BR>
<TT>objectClass: top</TT><BR>
<TT>objectClass: automountMap</TT><BR>
<BR>
<TT>dn: automountkey=someuser,automountmapname=auto_home,dc=example,dc=com</TT><BR>
<TT>objectClass: automount</TT><BR>
<TT>objectClass: top</TT><BR>
<TT>automountKey: someuser</TT><BR>
<TT>automountInformation: -rw&nbsp;&nbsp;&nbsp; server:/export/home/&amp;</TT><BR>
<BR>
Hope this helps.<BR>
<BR>
-Steve<BR>
<BR>
</BODY>
</HTML>

--=-Ed7UMYk0MBFdNi64cYVx--


--===============7872380987377030805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7872380987377030805==--

