From: Hans Deragon <hans@deragon.biz>
Subject: backfstype parameter supported.
Date: Tue, 29 Jun 2004 08:40:13 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40E1632D.1080903@deragon.biz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
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

Greetings.


  Newbie with automount.  Its been a week I tried to communicate with H. Peter
Anvin at hpa|at|zytor.com but never received any answer.  I then found this
mailing list.

  cachefs is not supported by Linux.  In a mix Solaris/Linux environment,
where NIS is provided by Solaris, many yp maps specify cachefs as the
filesystem, but backfstype is set to nfs.  Automount does not support backfstype.

  Here is a exert of an entry:

.. fstype=cachefs,cachedir=<dir>,backfstype=nfs ...

  I changed the code and now I have a modified 4.1.3 version which tries for
the filesystem defined with "fstype" and if this fails, "backfstype" is then
tried.  It works.

  My patch is not perfect though.  While trying "cachefs", modprobe errors
shows up in /var/log/messages.  Until backfstype also fails, ideally no error
message should be emitted.  Maybe there is a way to test for the existance of
the kernel module before actually try to load it, thus avoiding error messages.

  Altough I am a programmer, I do not program in C and do know pratically
nothing about system calls.  I would like my patch to be accepted in the main
branch and that someone experienced with autofs clean it up.

  Please comment.  I would be glade to send you the patch, but first I have to
read "man patch" to figure out how to generate one. :)  Its a pretty small
change to the code.


Best regards,
Hans Deragon
--
Consultant en informatique/Software Consultant
Deragon Informatique inc.     Open source:
http://www.deragon.biz        http://facil.qc.ca (Promotion du libre)
mailto://hans@deragon.biz     http://autopoweroff.sourceforge.net (Logiciel)
