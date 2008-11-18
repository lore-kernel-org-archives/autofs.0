From: Joe Pruett <joey@clean.q7.com>
Subject: hung server again
Date: Tue, 18 Nov 2008 07:40:06 -0800 (PST)
Message-ID: <alpine.LRH.2.00.0811180725001.21620@q7.q7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

a few months back i had a situation where a child of automount wouldn't 
exit properly and that would cause the parent to get locked up and all 
automount would stop working.  if i could get onto the system, i could 
strace the child automounts and watch them exit and eventually i'd hit the 
one that was the cause and then everything would start working again. 
there have been a number of kernel updates since and it looked like things 
were working normally again.  but i was wrong, our web server locked up 
last night from the same issue again.  given the length of time between 
issues and the infeasibility of debugging this on a live server i want to 
ask about my setup and see if i should change things.

i use a two level automount hierarchy.  /home entries are all designed to 
be bind mounts, like:

joey	:/disks/hyperion.0/home/joey

and then /disks is a normal automount map:

hyperion.0	hyperion:/disk/0

repeat this for a few thousand /home entries, but only a handful of 
entries in /disks.  i have done this to avoid thousands of nfs mounts on a 
busy server (like a mail server).  in the past with udp it was bad enough, 
but now with tcp based nfs, each mount uses even more resources (sockets, 
tcp buffers, etc).  but given this lockup bug, i am thinking of going to a 
straight single level /home setup.

i did some testing with a single level /home and if i touch all entries in 
/home, i eventually ran into some resource limits.  maybe there is some 
tuning i can do?  i could go back to /home just being full of symlinks, 
but that has so many issues of it's own. i'm looking for feedback of other 
users that might have servers with a thousand or more active mounts and 
how that works for you.  or some other good ideas of how people handle 
this kind of thing.
