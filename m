From: "Hassan Iqbal" <mhiqbal80@gmail.com>
Subject: automount: lookup(program) failed issue
Date: Mon, 23 Jul 2007 19:03:17 +0530
Message-ID: <121a9130707230633s6ca900afncbca7e6b65f459a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3349300537815990350=="
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

--===============3349300537815990350==
Content-Type: multipart/alternative; 
	boundary="----=_Part_133116_33391972.1185197597842"

------=_Part_133116_33391972.1185197597842
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
 I read the discussion thread on
http://osdir.com/ml/kernel.autofs/2005-08/msg00018.html that deals with the
lookup failed issue with autofs. I have linux kernel 2.6.11.7. I downloaded
autofs-4.1.4.tar.gz from:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/

Applied the patches that are suggested in the above discussion thread.

autofs-4.1.4-misc-fixes.patch
autofs-4.1.4-multi-parse-fix.patch
autofs-4.1.4-multi-parse-fix.patch

Built and installed it on my machine. But Iam still getting that lookup
failed messages and autofs seems to hang.
Can anyone please point me what Iam missing here.

Regards,
Hassan

------=_Part_133116_33391972.1185197597842
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>&nbsp;I read the discussion thread on <a class="moz-txt-link-freetext" href="http://osdir.com/ml/kernel.autofs/2005-08/msg00018.html">http://osdir.com/ml/kernel.autofs/2005-08/msg00018.html</a> that deals with the <br>lookup failed issue with autofs. I have linux kernel 
<a href="http://2.6.11.7">2.6.11.7</a>. I downloaded autofs-4.1.4.tar.gz from:<br><br><a href="ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/">ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/</a><br><br>Applied the patches that are suggested in the above discussion thread. 
<br><br>autofs-4.1.4-misc-fixes.patch<br>autofs-4.1.4-multi-parse-fix.patch<br>autofs-4.1.4-multi-parse-fix.patch<br><br>Built and installed it on my machine. But Iam still getting that lookup failed messages and autofs seems to hang. 
<br>Can anyone please point me what Iam missing here.<br><br>Regards,<br>Hassan<br>

------=_Part_133116_33391972.1185197597842--


--===============3349300537815990350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3349300537815990350==--

