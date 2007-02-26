From: "Brian Weaver" <bjweaverj@gmail.com>
Subject: Problem with /net and dropped mounts in 2.6.17.11
Date: Mon, 26 Feb 2007 08:21:20 -0700
Message-ID: <ac37e1230702260721u306898f8g4fae054a5812af8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8548096509183932944=="
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

--===============8548096509183932944==
Content-Type: multipart/alternative; 
	boundary="----=_Part_95461_14858897.1172503280658"

------=_Part_95461_14858897.1172503280658
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

We recently moved one of our projects from 2.6.12 up to 2.6.17.11 for some
hardware enablement reasons, but now we are seeing mounts consistently drop.

We have a dedicated NFS fileserver with 9 exported mount points. Our Linux
clients
are using /etc/auto.net to mount these on /net.  Everything works fine on
initial
startup, all of the mounts show up fine, but then after a while, one of the
mounts
disappears, is no longer mounted or in /etc/mtab, and automounter logs the
following
to syslog whenever we try to access the mount:

Feb 26 08:01:08 fclw436 automount[25387]: >> /sbin/showmount: can't get
address for cvl-xp1/mnt/xp1b
Feb 26 08:01:08 fclw436 automount[25387]: lookup(program): lookup for
cvl-xp1/mnt/xp1b failed
Feb 26 08:01:08 fclw436 automount[25387]: failed to mount
/net/cvl-xp1/mnt/xp1b

So it looks like showmount is actually failing.. It shouldn't be looking up
host cvl-xp1/mnt/xp1b..

Am I just running into an old showmount bug?

------=_Part_95461_14858897.1172503280658
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,<br><br>We recently moved one of our projects from 2.6.12 up to <a href="http://2.6.17.11">2.6.17.11</a> for some hardware enablement reasons, but now we are seeing mounts consistently drop.<br><br>We have a dedicated NFS fileserver with 9 exported mount points. Our Linux clients
<br>are using /etc/auto.net to mount these on /net.&nbsp; Everything works fine on initial<br>startup, all of the mounts show up fine, but then after a while, one of the mounts<br>disappears, is no longer mounted or in /etc/mtab, and automounter logs the following
<br>to syslog whenever we try to access the mount:<br><br><div>


<p><font face="Arial" size="2">Feb 26 08:01:08 fclw436 automount[25387]: &gt;&gt; /sbin/showmount: can&#39;t get address for cvl-xp1/mnt/xp1b</font>

<br><font face="Arial" size="2">Feb 26 08:01:08 fclw436 automount[25387]: lookup(program): lookup for cvl-xp1/mnt/xp1b failed</font>

<br><font face="Arial" size="2">Feb 26 08:01:08 fclw436 automount[25387]: failed to mount /net/cvl-xp1/mnt/xp1b</font>
</p>

</div>

<br>So it looks like showmount is actually failing.. It shouldn&#39;t be looking up host cvl-xp1/mnt/xp1b.. <br><br>Am I just running into an old showmount bug? <br><br>

------=_Part_95461_14858897.1172503280658--


--===============8548096509183932944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8548096509183932944==--

