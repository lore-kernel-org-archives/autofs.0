From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Performance of autofs/amd-managed directory
Date: Tue, 25 May 2004 20:02:34 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040526030234.47115.qmail@web20025.mail.yahoo.com>
Mime-Version: 1.0
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

What is the performance penalty for write access to files in a managed
directory vs. a fstab entry?
I have a program that is very sensitive to write latency, and am being
pressured to use amd or automount to access a NAS instead of my trusty fstab
entry.

My app uses a transactional log file that resides on a NAS.  I'd prefer to keep
a simple fstab entry and use O_DIRECT to access the file, but if there is no
penalty, I would switch.  Does O_DIRECT have meaning for automount or
amd-managed files?  (isn't amd user-space, so it would need to copy data
anyway?)

thanks,
-Kenny



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
