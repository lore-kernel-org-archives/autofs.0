From: Andy Grimm <ag381597@ohio.edu>
Subject: continued instability in autofs v3
Date: Sat, 06 Mar 2004 19:34:19 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1078619658.22401.11.camel@desktop.init4.org>
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

Hello, all.  I'm writing about a problem discussed in a thread back in
September under the subject "[NFS] VFS: Busy inodes after unmount on 2
way SMP".  I have been experiencing these issues on an increasing number
of servers, and was wondering if any progress had been made in either
autofs3 or autofs4.  I'm currently working with the RH 2.4.20-28.7smp
kernel.  Unfortunately, I am not in control of the NFS servers, and I
have to deal with the fact that they get rebooted on the weekends
sometimes, and that sometimes processes on my servers are in the middle
of accessing the mounts when they go away.  Is there any way to make the
system stable again after this event occurs, or is rebooting the only
answer?

Thanks.

--Andy
