From: Raymond Prach <rprach@us.ibm.com>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Fri, 9 Apr 2004 10:17:56 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <OF602ECAC6.8CFD3CF1-ON85256E71.004B70E0-04256E71.004E8C14@us.ibm.com>
References: <Pine.LNX.4.58.0404091319060.5256@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============71444516258472435=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404091319060.5256@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

This is a multipart message in MIME format.
--===============71444516258472435==
Content-Type: multipart/alternative;
	boundary="=_alternative 004E8C1004256E71_="

This is a multipart message in MIME format.
--=_alternative 004E8C1004256E71_=
Content-Type: text/plain; charset="US-ASCII"

Thanks so much for your ongoing help. I will try to answer your questions 
as best as I'm able...

I'm curious. Does the AIX 5 automounter still polute the mount table with 
heaps of entries if you have a large direct mount table (as it did in AIX 
4)?

Not sure. The AIX systems in question are using the am-utils automounter, 
which leaves the mount table tidy but, at least for us, has a habit of 
blowing up every so often, taking the machine down with it....

First, the version of mount that I'm using doesn't seem to hang the way it 

used to. What version of util-linux (or mount) are you using? I have 
2.11y.

Second thing I notice is that autofs-4.1.2 discovers the bogus mount very 
quickly (<1 sec) and so even with a stop watch I can't get the mount to 
be active at the same time as the expire.

Mount is 2.11y as well. I will upgrade the userspace automounter to 4.1.2 
and see if it helps. But I don't understand how autofs can possibly decide 
that the remote host is down or unavailable and quit attempting the mount 
in that short (<1 sec) time period. The remote hosts in question have 
valid DNS names, they're just powered off or otherwise unavailable. Hence 
the mount attempt taking some time is perfectly reasonable... right? Or am 
I being an idiot? I feel like I've been unclear in describing the 
situation...

Oh yes: the kernel version is 2.4.26-pre3, though 2.4.25 exhibits the same 
behavior.

I will update the userspace automounter. Do I need to load autofs4 instead 
of autofs as well?

r.
--=_alternative 004E8C1004256E71_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Thanks so much for your ongoing help.
I will try to answer your questions as best as I'm able...</font>
<br>
<br><font size=2><tt>I'm curious. Does the AIX 5 automounter still polute
the mount table with <br>
heaps of entries if you have a large direct mount table (as it did in AIX
<br>
4)?</tt></font>
<br>
<br><font size=2 face="sans-serif">Not sure. The AIX systems in question
are using the am-utils automounter, which leaves the mount table tidy but,
at least for us, has a habit of blowing up every so often, taking the machine
down with it....</font>
<br>
<br><font size=2><tt>First, the version of mount that I'm using doesn't
seem to hang the way it <br>
used to. What version of util-linux (or mount) are you using? I have <br>
2.11y.<br>
<br>
Second thing I notice is that autofs-4.1.2 discovers the bogus mount very
<br>
quickly (&lt;1 sec) and so even with a stop watch I can't get the mount
to <br>
be active at the same time as the expire.</tt></font>
<br>
<br><font size=2 face="sans-serif">Mount is 2.11y as well. I will upgrade
the userspace automounter to 4.1.2 and see if it helps. But I don't understand
how autofs can possibly decide that the remote host is down or unavailable
and quit attempting the mount in that short (&lt;1 sec) time period. The
remote hosts in question have valid DNS names, they're just powered off
or otherwise unavailable. Hence the mount attempt taking some time is perfectly
reasonable... right? Or am I being an idiot? I feel like I've been unclear
in describing the situation...</font>
<br>
<br><font size=2 face="sans-serif">Oh yes: the kernel version is 2.4.26-pre3,
though 2.4.25 exhibits the same behavior.</font>
<br>
<br><font size=2 face="sans-serif">I will update the userspace automounter.
Do I need to load autofs4 instead of autofs as well?</font>
<br>
<br><font size=2 face="sans-serif">r.</font>
--=_alternative 004E8C1004256E71_=--


--===============71444516258472435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============71444516258472435==--

