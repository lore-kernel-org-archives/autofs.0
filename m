From: Raymond Prach <rprach@us.ibm.com>
Subject: "Busy inodes after unmount. Self destruct in 5 seconds..."
Date: Wed, 7 Apr 2004 15:22:11 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <OFBFF7C508.11CDF1FE-ON85256E6F.00696B8E-04256E6F.006A66DA@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============53838832583574092=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

This is a multipart message in MIME format.
--===============53838832583574092==
Content-Type: multipart/alternative;
	boundary="=_alternative 006A66D704256E6F_="

This is a multipart message in MIME format.
--=_alternative 006A66D704256E6F_=
Content-Type: text/plain; charset="US-ASCII"

Dear Folks,

I am administrating a set of Linux servers that use automount and amd in 
order to access a variety of NFS volumes. The servers are, for the most 
part, running kernel 2.4.25 (but see below). We are using the kernel 
automounter version 3 and the userspace automount binary v3.1.7. 

We have a script that accesses resources all over the network. To this 
end, it mounts, via autofs, a large number of remote filesystems. Whenever 
this script is run, the following alarming message appears in the system 
log:

kernel: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have 
a nice day...

I searched the mailing list of this archive and found some threads from 
September of last year which seem to detail the same problem, however, no 
solution or workaround was proposed at that time.

Looking at kernel.org, I see that kernel 2.4.26-pre3 contains a patch that 
is supposed to help fix this problem. This patch was duly applied, but the 
message persists. 

Questions: What is causing this message? Is there anything I can do about 
it? Is there anything I should be doing about it, or is it an alarming yet 
irrelevant message? 

Any insight you could shed would be greatly appreciated.

Yours Truly,

Raymond Prach
--=_alternative 006A66D704256E6F_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Dear Folks,</font>
<br>
<br><font size=2 face="sans-serif">I am administrating a set of Linux servers
that use automount and amd in order to access a variety of NFS volumes.
The servers are, for the most part, running kernel 2.4.25 (but see below).
We are using the kernel automounter version 3 and the userspace automount
binary v3.1.7. </font>
<br>
<br><font size=2 face="sans-serif">We have a script that accesses resources
all over the network. To this end, it mounts, via autofs, a large number
of remote filesystems. Whenever this script is run, the following alarming
message appears in the system log:</font>
<br>
<br><font size=2 face="sans-serif">kernel: VFS: Busy inodes after unmount.
Self-destruct in 5 seconds. &nbsp;Have a nice day...</font>
<br>
<br><font size=2 face="sans-serif">I searched the mailing list of this
archive and found some threads from September of last year which seem to
detail the same problem, however, no solution or workaround was proposed
at that time.</font>
<br>
<br><font size=2 face="sans-serif">Looking at kernel.org, I see that kernel
2.4.26-pre3 contains a patch that is supposed to help fix this problem.
This patch was duly applied, but the message persists. </font>
<br>
<br><font size=2 face="sans-serif">Questions: What is causing this message?
Is there anything I can do about it? Is there anything I should be doing
about it, or is it an alarming yet irrelevant message? </font>
<br>
<br><font size=2 face="sans-serif">Any insight you could shed would be
greatly appreciated.</font>
<br>
<br><font size=2 face="sans-serif">Yours Truly,</font>
<br>
<br><font size=2 face="sans-serif">Raymond Prach</font>
--=_alternative 006A66D704256E6F_=--


--===============53838832583574092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============53838832583574092==--

