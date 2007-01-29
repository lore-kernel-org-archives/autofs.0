From: Jeff Moyer <jmoyer@redhat.com>
Subject: [Murata,
	Dennis] FW: Advise for multiple directory/multi-map mounts
Date: Mon, 29 Jan 2007 13:14:17 -0500
Message-ID: <x4964ap4s5i.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5977834318971481612=="
Return-path: <autofs-bounces@linux.kernel.org>
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

--===============5977834318971481612==
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <DENNIS.MURATA@saic.com>
Received: from mail.boston.redhat.com ([unix socket])
	by mail.boston.redhat.com (Cyrus v2.1.12) with LMTP;
	Mon, 29 Jan 2007 12:59:01 -0500
X-Sieve: CMU Sieve 2.2
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id
	l0THx0bh018270
	for <jmoyer@boston.redhat.com>; Mon, 29 Jan 2007 12:59:01 -0500
Received: from mx2.redhat.com (mx2.redhat.com [10.255.15.25])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l0THwxOP027648
	for <jmoyer@redhat.com>; Mon, 29 Jan 2007 12:58:59 -0500
Received: from cpmx2.mail.saic.com
	(IDENT:U2FsdGVkX19iWLVfGSAwjiN+GhsJDJxt7eSlC8glfpU@cpmx2.mail.saic.com
	[139.121.17.172])
	by mx2.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id
	l0THwoax028649
	for <jmoyer@redhat.com>; Mon, 29 Jan 2007 12:58:50 -0500
Received: from 0599-its-ieg01.mail.saic.com ([139.121.18.36] [139.121.18.36])
	by cpmx2.mail.saic.com for jmoyer@redhat.com;
	Mon, 29 Jan 2007 09:58:36 -0800
Received: from 0599-its-exbh02.us.saic.com ([139.121.18.36])
	by 0599-its-ieg01.mail.saic.com (SMSSMTP 4.0.5.66) with SMTP id
	M2007012909583609356
	for <jmoyer@redhat.com>; Mon, 29 Jan 2007 09:58:36 -0800
Received: from 0599-its-exmb02.us.saic.com ([10.8.67.14]) by
	0599-its-exbh02.us.saic.com with Microsoft SMTPSVC(6.0.3790.1830); 
	Mon, 29 Jan 2007 09:58:36 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
Subject: FW: Advise for multiple directory/multi-map mounts
Date: Mon, 29 Jan 2007 09:57:03 -0800
Message-Id: <56D01C1B776AEE4385D29F25E83E515C09150791@0599-its-exmb02.us.saic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Advise for multiple directory/multi-map mounts
Thread-Index: AcdBhWScDG0lvka/SFSUF02RsQhRJQCSSGGQ
From: "Murata, Dennis" <DENNIS.MURATA@saic.com>
To: <jmoyer@redhat.com>
X-OriginalArrivalTime: 29 Jan 2007 17:58:36.0542 (UTC)
	FILETIME=[1951A1E0:01C743CF]
X-RedHat-Spam-Score: 0.91 
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="==-=-="

--==-=-=

Jeff,

I am sorry about sending this directly to you, but I have not been able
to post anything to the autofs mailing list in quite awhile.  I think I
will unsubscribe then resubscribe.  Would you please post this for me?

Thanks
Wayne

> ______________________________________________ 
> From: 	Murata, Dennis  
> Sent:	Friday, January 26, 2007 2:06 PM
> To:	autofs@linux.kernel.org
> Subject:	Advise for multiple directory/multi-map mounts
> 
> After reading the FAQ and various postings from this group, there are
> a couple of options that I need advise with the approved syntax and
> any recommendations for either one of the options.
> 
> auto.master entry:
>      /foo     /etc/auto.foo
> indirect map auto.foo:
>      *   -fstype=nfs,rsize=32768,tcp server1:/foo1/& server2:/foo2/&
> 
> Server1 and server2 may or may not be the same server, but the server
> directories foo1 and foo2 are definitely distinct.  The subdirectories
> under foo1 and foo2 do not have overlapping names, but may be moved
> from one server foo1, to the other server directory foo2.  I want it
> to appear transparently to the client.  Because directories are going
> to be moved, should no_subtree_check be used?
> 
> The second option I see would use multi-maps.
> 
> auto.master entry:
>      /foo     multi: file /etc/auto.foo -- yp map.in.nis
> file /etc/auto.foo
>      *   -fstype=nfs,rsize=32768,tcp server1:/foo1/&
> NIS map auto.foo
>      *   -fstype=nfs,rsize=32768,tcp server2:/foo2/&
> 
> I have never used multi-maps, but would it also be possible to use the
> following:
> 
> auto.master entry:
>      /foo    multi: file /etc/auto.foo1 -- file /etc/auto.foo2
> file /etc/auto.foo1
>      *   -fstype=nfs,rsize=32768,tcp server1:/foo1/&
> file /etc/auto.foo2
>      *   -fstype=nfs,rsize=32768,tcp server2:/foo2/&
> 
> Any and all advice and recommendations are greatly appreciated.
> 
> Wayne Murata

--==-=-=
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">
<META NAME="Generator" CONTENT="MS Exchange Server version 6.5.7651.32">
<TITLE>FW: Advise for multiple directory/multi-map mounts</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT COLOR="#0000FF" SIZE=2 FACE="Arial">Jeff,</FONT>
</P>

<P><FONT COLOR="#0000FF" SIZE=2 FACE="Arial">I am sorry about sending this directly to you, but I have not been able to post anything to the autofs mailing list in quite awhile.&nbsp; I think I will unsubscribe then resubscribe.&nbsp; Would you please post this for me?</FONT></P>

<P><FONT COLOR="#0000FF" SIZE=2 FACE="Arial">Thanks</FONT>

<BR><FONT COLOR="#0000FF" SIZE=2 FACE="Arial">Wayne</FONT>
</P>

<P><FONT SIZE=1 FACE="Tahoma">______________________________________________ </FONT>

<BR><B><FONT SIZE=1 FACE="Tahoma">From: &nbsp;</FONT></B> <FONT SIZE=1 FACE="Tahoma">Murata, Dennis&nbsp; </FONT>

<BR><B><FONT SIZE=1 FACE="Tahoma">Sent:&nbsp;&nbsp;</FONT></B> <FONT SIZE=1 FACE="Tahoma">Friday, January 26, 2007 2:06 PM</FONT>

<BR><B><FONT SIZE=1 FACE="Tahoma">To:&nbsp;&nbsp;&nbsp;&nbsp;</FONT></B> <FONT SIZE=1 FACE="Tahoma">autofs@linux.kernel.org</FONT>

<BR><B><FONT SIZE=1 FACE="Tahoma">Subject:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></B> <FONT SIZE=1 FACE="Tahoma">Advise for multiple directory/multi-map mounts</FONT>
</P>

<P><FONT SIZE=2 FACE="Arial">After reading the FAQ and various postings from this group, there are a couple of options that I need advise with the approved syntax and any recommendations for either one of the options.</FONT></P>

<P><FONT SIZE=2 FACE="Arial">auto.master entry:</FONT>

<BR><FONT SIZE=2 FACE="Arial">&nbsp;&nbsp;&nbsp;&nbsp; /foo&nbsp;&nbsp;&nbsp;&nbsp; /etc/auto.foo</FONT>

<BR><FONT SIZE=2 FACE="Arial">indirect map auto.foo:</FONT>

<BR><FONT SIZE=2 FACE="Arial">&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; -fstype=nfs,rsize=32768,tcp server1:/foo1/&amp; server2:/foo2/&amp;</FONT>
</P>

<P><FONT SIZE=2 FACE="Arial">Server1 and server2 may or may not be the same server, but the server directories foo1 and foo2 are definitely distinct.&nbsp; The subdirectories under foo1 and foo2 do not have overlapping names, but may be moved from one server foo1, to the other server directory foo2.&nbsp; I want it to appear transparently to the client.&nbsp; Because directories are going to be moved, should no_subtree_check be used?</FONT></P>

<P><FONT SIZE=2 FACE="Arial">The second option I see would use multi-maps.</FONT>
</P>

<P><FONT SIZE=2 FACE="Arial">auto.master entry:</FONT>

<BR><FONT SIZE=2 FACE="Arial">&nbsp;&nbsp;&nbsp;&nbsp; /foo&nbsp;&nbsp;&nbsp;&nbsp; multi: file /etc/auto.foo -- yp map.in.nis</FONT>

<BR><FONT SIZE=2 FACE="Arial">file /etc/auto.foo</FONT>

<BR><FONT SIZE=2 FACE="Arial">&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; -fstype=nfs,rsize=32768,tcp server1:/foo1/&amp;</FONT>

<BR><FONT SIZE=2 FACE="Arial">NIS map auto.foo</FONT>

<BR><FONT SIZE=2 FACE="Arial">&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; -fstype=nfs,rsize=32768,tcp server2:/foo2/&amp;</FONT>
</P>

<P><FONT SIZE=2 FACE="Arial">I have never used multi-maps, but would it also be possible to use the following:</FONT>
</P>

<P><FONT SIZE=2 FACE="Arial">auto.master entry:</FONT>

<BR><FONT SIZE=2 FACE="Arial">&nbsp;&nbsp;&nbsp;&nbsp; /foo&nbsp;&nbsp;&nbsp; multi: file /etc/auto.foo1 -- file /etc/auto.foo2</FONT>

<BR><FONT SIZE=2 FACE="Arial">file /etc/auto.foo1</FONT>

<BR><FONT SIZE=2 FACE="Arial">&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; -fstype=nfs,rsize=32768,tcp server1:/foo1/&amp;</FONT>

<BR><FONT SIZE=2 FACE="Arial">file /etc/auto.foo2</FONT>

<BR><FONT SIZE=2 FACE="Arial">&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; -fstype=nfs,rsize=32768,tcp server2:/foo2/&amp;</FONT>
</P>

<P><FONT SIZE=2 FACE="Arial">Any and all advice and recommendations are greatly appreciated.</FONT>
</P>

<P><FONT SIZE=2 FACE="Arial">Wayne Murata</FONT>
</P>

</BODY>
</HTML>
--==-=-=--


--===============5977834318971481612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5977834318971481612==--
