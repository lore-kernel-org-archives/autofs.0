From: "Andreas Neuper" <ANeuper@web.de>
Subject: Is the "program" format correct ?
Date: Sun, 08 Aug 2004 16:47:34 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1399068150@web.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hello,

I am new to the list.  I wanted to use the program format to provide some good solution.
Unfortunately, it showed a strange behaviour.  It seems to me, nobody really ever used it!
Your example delivered with the distribuion works, although it should not IMHO.  
I would expect that the program format causes the same action as
e.g. a nis-map or a file. Maybe I am wrong with my expectations. 
Try this: 

~# cat /etc/auto.master
/auto   /etc/auto.auto

~# cat <<*** >/etc/auto.cat
#!/bin/sh
grep -v ^# /etc/auto.auto
exit 0
***
~# chmod a+x /etc/auto.cat
~# /etc/auto.cat

floppy  -fstype=auto                            :/dev/fd0
video   -fstype=nfs,rw,rsize=8192,wsize=8192    ok:/home/video

~# echo "/tmp/cat       /etc/auto.cat" >> /etc/auto.master
~# /etc/rc.d/autofs restart
~# ls /auto/video
.       ..      DVD
~# ls /tmp/cat/
.       ..
~# ls /tmp/cat/video
^C
~# tail -5 /var/log/messages
Aug  8 16:26:21 akemi automount[6212]: mount(nfs): host -fstype=auto: lookup failure
Aug  8 16:26:21 akemi automount[6212]: mount(nfs): host : lookup failure
Aug  8 16:26:21 akemi automount[6215]: mount(nfs): host floppy: lookup failure
Aug  8 16:26:21 akemi automount[6215]: mount(nfs): host -fstype=auto: lookup failure
Aug  8 16:26:21 akemi automount[6215]: mount(nfs): host : lookup failure

thanks for reading.  Is there a simple solution?
Andreas
____________________________________________________
Aufnehmen, abschicken, nah sein - So einfach ist 
WEB.DE Video-Mail: http://freemail.web.de/?mc=021200
