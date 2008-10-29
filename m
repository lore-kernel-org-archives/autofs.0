From: Stef Bon <stef@bononline.nl>
Subject: Re: Modified auto.smb script
Date: Wed, 29 Oct 2008 11:09:00 +0100
Message-ID: <200810291109.01097.stef@bononline.nl>
References: <200810241646.56647.stef@bononline.nl>
	<1225116020.2990.33.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1496677374213302030=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1225116020.2990.33.camel@zeus.themaw.net>
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

--===============1496677374213302030==
Content-Type: multipart/alternative;
  boundary="Boundary-00=_9YDCJVZiZb5RQXT"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_9YDCJVZiZb5RQXT
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

On Monday 27 October 2008 15:00:20 Ian Kent wrote:
> On Fri, 2008-10-24 at 16:46 +0200, Stef Bon wrote:
> > Hi,
> >
> >
> >
> > I've sent this email before. Can you confirm it's arrived?
>
> Yeah, I've received your mail.
> What do you want me to do with the script?
>
Well, the script does (in my network) work with cifs shares, where the 
original auto.smb doesn't. In my case I have to add the ipaddress or it does 
not work. The manpage of mount.cifs says that this option has to be used 
rarely. But it's my experience sometimes when mounting a Win2K or WinXP 
machine, it does not work.
(CIFS expects the tcp name and not the netbiosname, smbfs did that)

So I cannot say it's a really "must", but at least it cannot "hurt". You're on 
the safe side when using the ipaddress.

Well I should add this script to the package autofs, replacing the auto.smb, 
if you want my opinion. 

Smbfs is not supported anymore in the latest kernels.

Stef





--Boundary-00=_9YDCJVZiZb5RQXT
Content-Type: text/html;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd"><html><head><meta name="qrichtext" content="1" /><style type="text/css">p, li { white-space: pre-wrap; }</style></head><body style=" font-family:'Sans Serif'; font-size:10pt; font-weight:400; font-style:normal;">On Monday 27 October 2008 15:00:20 Ian Kent wrote:<br>
&gt; On Fri, 2008-10-24 at 16:46 +0200, Stef Bon wrote:<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I've sent this email before. Can you confirm it's arrived?<br>
&gt;<br>
&gt; Yeah, I've received your mail.<br>
&gt; What do you want me to do with the script?<br>
&gt;<br>
Well, the script does (in my network) work with cifs shares, where the original auto.smb doesn't. In my case I have to add the ipaddress or it does not work. The manpage of mount.cifs says that this option has to be used rarely. But it's my experience sometimes when mounting a Win2K or WinXP machine, it does not work.<br>
(CIFS expects the tcp name and not the netbiosname, smbfs did that)<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>So I cannot say it's a really "must", but at least it cannot "hurt". You're on the safe side when using the ipaddress.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Well I should add this script to the package autofs, replacing the auto.smb, if you want my opinion. <br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Smbfs is not supported anymore in the latest kernels.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Stef<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p><p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p><p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p><p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p></body></html>
--Boundary-00=_9YDCJVZiZb5RQXT--


--===============1496677374213302030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1496677374213302030==--

