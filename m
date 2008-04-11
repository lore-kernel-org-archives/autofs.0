From: Robert Kuropkat <robert.a.kuropkat@saic.com>
Subject: [Fwd: Fwd:  autofs-5.0.1-0.rc2.55.el5.3 core dump]
Date: Fri, 11 Apr 2008 14:42:57 -0400
Message-ID: <47FFB131.5070603@saic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040701020108020800090309"
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

This is a multi-part message in MIME format.
--------------040701020108020800090309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I am also have this problem on FC6 with:

Name   : autofs
Arch   : i386
Epoch  : 1
Version: 5.0.1
Release: 0.rc3.33

I **believe** the core dumps started after I updated to this version but 
can't be sure about that.  I also can supply a core dump if you post 
where to send it.

Additionally, I am using autofs in conjunction with LDAP.

Robert Kuropkat



--------------040701020108020800090309
Content-Type: message/rfc822;
	name="Fwd: [autofs] autofs-5.0.1-0.rc2.55.el5.3 core dump"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="Fwd: [autofs] autofs-5.0.1-0.rc2.55.el5.3 core dump"

Return-Path: <peter@devries.tv>
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on
	orbit.objectsciences.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.3 tests=HTML_MESSAGE autolearn=failed
	version=3.1.9
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.184])
	by orbit.objectsciences.com (8.14.1/8.13.8) with ESMTP id
	m3BIDl1M012351
	for <rkuropkat@objectsciences.com>; Fri, 11 Apr 2008 14:13:47 -0400
Received: by rn-out-0910.google.com with SMTP id e21so583841rng.6
	for <rkuropkat@objectsciences.com>;
	Fri, 11 Apr 2008 11:25:59 -0700 (PDT)
Received: by 10.114.130.1 with SMTP id c1mr622081wad.156.1207938358493;
	Fri, 11 Apr 2008 11:25:58 -0700 (PDT)
Received: by 10.114.95.13 with HTTP; Fri, 11 Apr 2008 11:25:58 -0700 (PDT)
Message-ID: <50cd6cea0804111125x7d00e0eeyb8cb96821d256695@mail.gmail.com>
Date: Fri, 11 Apr 2008 14:25:58 -0400
From: "Peter DeVries" <peter@devries.tv>
To: "Robert Kuropkat" <rkuropkat@objectsciences.com>
Subject: Fwd: [autofs] autofs-5.0.1-0.rc2.55.el5.3 core dump
In-Reply-To: <47FF8D07.7080208@schrodinger.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8258_30127449.1207938358489"
References: <47FF8D07.7080208@schrodinger.com>
X-Virus-Scanned: ClamAV 0.88.7/6704/Fri Apr 11 09:41:43 2008 on
	orbit.objectsciences.com
X-Virus-Status: Clean

------=_Part_8258_30127449.1207938358489
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

If your were monitoring this list you would see these things

---------- Forwarded message ----------
From: Simon Gao <gao@schrodinger.com>
Date: Fri, Apr 11, 2008 at 12:08 PM
Subject: [autofs] autofs-5.0.1-0.rc2.55.el5.3 core dump
To: autofs@linux.kernel.org


Hi,

We have many RHEL 5.1 desktops running 2.6.18-53.1.14 X86_64. Many of
them have core dump files related to autofs. The autofs package is
autofs-5.0.1-0.rc2.55.el5.3.

# strings core.2594 | head
@UUUU
@xUUU
PxUUU
QqUU
CORE
P*fqUU
dgqUU
CORE
automount
automount -DOSNAME=rhel -DOSREL=5

# strings core.3666 | head
@UUUU
 xUUU
@xUUU
BWUU
CORE
6xUUU
VWUU
XWUU
CORE
automount

What caused autofs to core dump? Is there a fix by upgrading to newer
version?

Simon












_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

------=_Part_8258_30127449.1207938358489
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

If your were monitoring this list you would see these things<br><br><div class="gmail_quote">---------- Forwarded message ----------<br>From: <b class="gmail_sendername">Simon Gao</b> &lt;<a href="mailto:gao@schrodinger.com">gao@schrodinger.com</a>&gt;<br>
Date: Fri, Apr 11, 2008 at 12:08 PM<br>Subject: [autofs] autofs-5.0.1-0.rc2.55.el5.3 core dump<br>To: <a href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a><br><br><br>Hi,<br>
<br>
We have many RHEL 5.1 desktops running 2.6.18-53.1.14 X86_64. Many of<br>
them have core dump files related to autofs. The autofs package is<br>
autofs-5.0.1-0.rc2.55.el5.3.<br>
<br>
# strings core.2594 | head<br>
@UUUU<br>
@xUUU<br>
PxUUU<br>
QqUU<br>
CORE<br>
P*fqUU<br>
dgqUU<br>
CORE<br>
automount<br>
automount -DOSNAME=rhel -DOSREL=5<br>
<br>
# strings core.3666 | head<br>
@UUUU<br>
&nbsp;xUUU<br>
@xUUU<br>
BWUU<br>
CORE<br>
6xUUU<br>
VWUU<br>
XWUU<br>
CORE<br>
automount<br>
<br>
What caused autofs to core dump? Is there a fix by upgrading to newer<br>
version?<br>
<br>
Simon<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
_______________________________________________<br>
autofs mailing list<br>
<a href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a><br>
<a href="http://linux.kernel.org/mailman/listinfo/autofs" target="_blank">http://linux.kernel.org/mailman/listinfo/autofs</a><br>
</div><br>

------=_Part_8258_30127449.1207938358489--


--------------040701020108020800090309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------040701020108020800090309--

