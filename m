From: "Breitman, Jason" <Jason.Breitman@blackrock.com>
Subject: nfs bindresvport: Address already in use
Date: Thu, 22 Sep 2005 10:08:10 -0400
Message-ID: <FB7BDBB2C6034E44B36CFDCF09256BCF029E982C@NYCPEXV003.na.blkint.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0345117977=="
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
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
To: autofs@linux.kernel.org

--===============0345117977==
content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5BF7F.100E6B62"

------_=_NextPart_001_01C5BF7F.100E6B62
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

rpm -q autofs
autofs-4.1.3-131

uname -r
2.6.9-5.Elsmp

/etc/auto.master
/usr/local              program:/usr/bin/autofs_local   --timeout=3600
--debug

/var/log/messages
Sep 22 09:41:18 bbc003 automount[4774]: >> nfs bindresvport: Address
already in use
Sep 22 09:41:18 bbc003 automount[4774]: mount(nfs): nfs: mount failure
nfs:/clients/local/data on /usr/local/data
Sep 22 09:41:18 bbc003 automount[4774]: failed to mount /usr/local/data

Configured Mount Points:
------------------------
/usr/sbin/automount --timeout=3600 --debug /usr/local program
/usr/bin/autofs_local 

Active Mount Points:
--------------------
/usr/sbin/automount --timeout=3600 --debug /usr/local program
/usr/bin/autofs_local

ps -ef | grep automount
root      2175     1  0 09:38 ?        00:00:00 /usr/sbin/automount
--timeout=3600 --debug /usr/local program /usr/bin/autofs_local


Problem
Automount fails to mount directories and application fail to run.

Bugzilla ID That appears to be similar
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=128966

Jason Breitman
jason.breitman@blackrock.com


THE INFORMATION CONTAINED IN THIS MESSAGE AND ANY ATTACHMENT MAY BE PRIVILEGED, CONFIDENTIAL, PROPRIETARY OR OTHERWISE PROTECTED FROM DISCLOSURE. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution, copying or use of this message and any attachment is strictly prohibited. If you have received this message in error, please notify us immediately by replying to the message and permanently delete it from your computer and destroy any printout thereof.
------_=_NextPart_001_01C5BF7F.100E6B62
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">
<META NAME="Generator" CONTENT="MS Exchange Server version 6.0.6603.0">
<TITLE>nfs bindresvport: Address already in use</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><B><FONT SIZE=2 FACE="Arial">rpm -q autofs</FONT></B>

<BR><FONT SIZE=2 FACE="Arial">autofs-4.1.3-131</FONT>
</P>

<P><B><FONT SIZE=2 FACE="Arial">uname -r</FONT></B>

<BR><FONT SIZE=2 FACE="Arial">2.6.9-5.Elsmp</FONT>
</P>

<P><B><FONT SIZE=2 FACE="Arial">/etc/auto.master</FONT></B>

<BR><FONT SIZE=2 FACE="Arial">/usr/local&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; program:/usr/bin/autofs_local&nbsp;&nbsp; --timeout=3600 --debug</FONT>
</P>

<P><B><FONT SIZE=2 FACE="Arial">/var/log/messages</FONT></B>

<BR><FONT SIZE=2 FACE="Arial">Sep 22 09:41:18 bbc003 automount[4774]: &gt;&gt; nfs bindresvport: Address already in use</FONT>

<BR><FONT SIZE=2 FACE="Arial">Sep 22 09:41:18 bbc003 automount[4774]: mount(nfs): nfs: mount failure nfs:/clients/local/data on /usr/local/data</FONT>

<BR><FONT SIZE=2 FACE="Arial">Sep 22 09:41:18 bbc003 automount[4774]: failed to mount /usr/local/data</FONT>
</P>

<P><FONT SIZE=2 FACE="Arial">Configured Mount Points:</FONT>

<BR><FONT SIZE=2 FACE="Arial">------------------------</FONT>

<BR><FONT SIZE=2 FACE="Arial">/usr/sbin/automount --timeout=3600 --debug /usr/local program /usr/bin/autofs_local </FONT>
</P>

<P><FONT SIZE=2 FACE="Arial">Active Mount Points:</FONT>

<BR><FONT SIZE=2 FACE="Arial">--------------------</FONT>

<BR><FONT SIZE=2 FACE="Arial">/usr/sbin/automount --timeout=3600 --debug /usr/local program /usr/bin/autofs_local</FONT>
</P>

<P><B><FONT SIZE=2 FACE="Arial">ps -ef | grep automount</FONT></B>

<BR><FONT SIZE=2 FACE="Arial">root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2175&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; 0 09:38 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:00:00 /usr/sbin/automount --timeout=3600 --debug /usr/local program /usr/bin/autofs_local</FONT></P>
<BR>

<P><B><FONT SIZE=2 FACE="Arial">Problem</FONT></B>

<BR><FONT SIZE=2 FACE="Arial">Automount fails to mount directories and application fail to run.</FONT>
</P>

<P><FONT SIZE=2 FACE="Arial">Bugzilla ID That appears to be similar</FONT>

<BR><A HREF="https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=128966"><U><FONT COLOR="#0000FF" SIZE=2 FACE="Arial">https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=128966</FONT></U></A>
</P>

<P><FONT SIZE=2 FACE="Arial">Jason Breitman</FONT>

<BR><FONT SIZE=2 FACE="Arial">jason.breitman@blackrock.com</FONT>
</P>

</BODY>
</HTML><br>
THE INFORMATION CONTAINED IN THIS MESSAGE AND ANY ATTACHMENT MAY BE PRIVILEGED, CONFIDENTIAL, PROPRIETARY OR OTHERWISE PROTECTED FROM DISCLOSURE. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution, copying or use of this message and any attachment is strictly prohibited. If you have received this message in error, please notify us immediately by replying to the message and permanently delete it from your computer and destroy any printout thereof.
------_=_NextPart_001_01C5BF7F.100E6B62--


--===============0345117977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0345117977==--

