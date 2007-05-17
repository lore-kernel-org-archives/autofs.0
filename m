From: "Kevin Muller" <k.muller@sideshowdigital.com>
Subject: autofs / davfs
Date: Thu, 17 May 2007 12:18:47 +0300
Message-ID: <4104f1cf0705170218ua2b6bbdu8f1456193741cd65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3456052310087960593=="
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

--===============3456052310087960593==
Content-Type: multipart/alternative; 
	boundary="----=_Part_22199_11001015.1179393527294"

------=_Part_22199_11001015.1179393527294
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

autofs / davfs

Im having a problem automounting a davfs share.
The share is setup, and works perfect without the automount.
but as soon as a 'ls' is done on the automount directory, and the autofs
tries to mount it, it hangs for a while, then if ctrl-c's out of it, the
next ls on that directory shows the files correctly.

The idea is to have the files available through Samba, and as soon as samba
tries to access the folder it will be a webdav share that gets mounted at
that point.

Any suggestions at this point will be helpful.

------=_Part_22199_11001015.1179393527294
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

autofs / davfs<br><br>Im having a problem automounting a davfs share.<br>The share is setup, and works perfect without the automount.<br>but as soon as a &#39;ls&#39; is done on the automount directory, and the autofs tries to mount it, it hangs for a while, then if ctrl-c&#39;s out of it, the next ls on that directory shows the files correctly.
<br><br>The idea is to have the files available through Samba, and as soon as samba tries to access the folder it will be a webdav share that gets mounted at that point.<br><br>Any suggestions at this point will be helpful.
<br>

------=_Part_22199_11001015.1179393527294--


--===============3456052310087960593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3456052310087960593==--

