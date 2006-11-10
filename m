From: "Stephen C. Rigler" <srigler@marathonoil.com>
Subject: Re: autofs to load MAP from LDAP
Date: Fri, 10 Nov 2006 08:32:32 -0600
Message-ID: <1163169152.22827.8.camel@houuc8>
References: <29c5cd460611082119u63dcc765j56c58c07f6ccd072@mail.gmail.com>
	<1163077907.9612.18.camel@houuc8>
	<29c5cd460611092033m2e0de71cpa6e9e29d74555c24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4353672256070320432=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <29c5cd460611092033m2e0de71cpa6e9e29d74555c24@mail.gmail.com>
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
To: Syed Khader <syedk@google.com>
Cc: autofs@linux.kernel.org


--===============4353672256070320432==
Content-Type: multipart/alternative; boundary="=-qVFu/WLjhYLxxBjJCGDR"


--=-qVFu/WLjhYLxxBjJCGDR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, 2006-11-10 at 10:03 +0530, Syed Khader wrote:

> But in my ldap entries i don't have automountmapname.


Might not be an issue.  Somebody else can confirm the behavior, but I do
recall while looking at my LDAP server logs that autofs was looking up
all possible combinations when search for the master map.  You can
verify either by looking at your server logs or running tcpdump or
wireshark/ethereal on your client while autofs is starting up.


> dn: cn=/home,ou=auto.master,dc=testlab,dc=com
> objectClass:automount
> cn:/home
> automountInformation: ldap
> server.testlab.com:ou=auto.home,dc=testlab,dc=com --timeout 60


Your automountinformation should probably be
"ldap:ou=auto.home,dc=testlab,dc=com --timeout 60".


>  What do i set LDAPAUTOMASTER to?


We set it because our auto.master has a different name.  I don't think
you'd need to if it's just "auto.master".

-Steve

--=-qVFu/WLjhYLxxBjJCGDR
Content-Type: text/html; charset=utf-8

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.3.2">
</HEAD>
<BODY>
<BR>
<BR>
On Fri, 2006-11-10 at 10:03 +0530, Syed Khader wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">But in my ldap entries i don't have automountmapname.</FONT><BR>
</BLOCKQUOTE>
<BR>
Might not be an issue.&nbsp; Somebody else can confirm the behavior, but I do recall while looking at my LDAP server logs that autofs was looking up all possible combinations when search for the master map.&nbsp; You can verify either by looking at your server logs or running tcpdump or wireshark/ethereal on your client while autofs is starting up.<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">dn: cn=/home,ou=auto.master,dc=testlab,dc=com</FONT><BR>
    <FONT COLOR="#000000">objectClass:automount</FONT><BR>
    <FONT COLOR="#000000">cn:/home</FONT><BR>
    <FONT COLOR="#000000">automountInformation: ldap server.testlab.com:ou=auto.home,dc=testlab,dc=com --timeout 60</FONT><BR>
</BLOCKQUOTE>
<BR>
Your automountinformation should probably be &quot;ldap:ou=auto.home,dc=testlab,dc=com --timeout 60&quot;.<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000"> What do i set LDAPAUTOMASTER to?</FONT><BR>
</BLOCKQUOTE>
<BR>
We set it because our auto.master has a different name.&nbsp; I don't think you'd need to if it's just &quot;auto.master&quot;.<BR>
<BR>
-Steve
</BODY>
</HTML>

--=-qVFu/WLjhYLxxBjJCGDR--


--===============4353672256070320432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4353672256070320432==--

