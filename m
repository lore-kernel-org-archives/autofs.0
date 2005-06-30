From: Jim Carter <jimc@math.ucla.edu>
Subject: Cached NIS map?
Date: Thu, 30 Jun 2005 10:36:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.61.0506301010100.19272@simba.math.ucla.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

This is seen with autofs-4.1.3.  I'm using a NIS map with this command 
line:
    /usr/sbin/automount /home yp auto.home
ypmatch -k mathtest auto.home says: mathtest julia:/h1/maint/mathtest
/home/mathtest cannot be mounted (i.e. any access returns "no such file or 
directory"), whereas other users on the same host can.  If the above 
automount process is killed and restarted (or the client is rebooted,  
same thing), /home/mathnet can then be mounted normally.

During the life of the automount process, the mathtest account (and a 
number of others, which also were affected) were moved from a differently 
named machine, and it's quite possible that the automounter on the affected 
clients mounted the old homedir at some time. On the other hand, some 
homedirs that were mounted normally were moved to a new machine with the 
same name but a different IP address.  To make this clear:

    State	Hostname	IP		Users on Server
    Before	julia		128.97.4.254	maggie
    Before	sonia		128.97.4.247	mathtest
    After	julia (new)	128.97.4.6	mathtest, maggie
    After	oldjulia	128.97.4.254	(none)

/home/mathtest could not be mounted until a restart; /home/maggie could.

But to make matters more obscure, four clients could not mount 
/home/maggie, of which one *could* mount /home/mathtest, and it is almost 
but not quite beyond imagination that any of them might have ever tried to 
mount /home/maggie before.  Restarting automount brought back both 
homedirs.

I'm wondering if the NIS map row is cached by automount with a very long 
timeout.  Or if anyone else recognizes the symptoms.  We're going to be 
moving a lot of users over the summer, and it looks like we're going to 
have to restart the automounter frequently.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
