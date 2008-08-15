From: Thanh Tran <ttran7700@yahoo.com>
Subject: Re: Fedora 8 And Autofs SOLVED!!
Date: Fri, 15 Aug 2008 06:22:13 -0700 (PDT)
Message-ID: <797320.57650.qm@web54306.mail.re2.yahoo.com>
References: <48A493C7.7030305@ssa.crane.navy.mil>
Reply-To: ttran7700@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48A493C7.7030305@ssa.crane.navy.mil>
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

After a lot of digging and lot of help from Ian, I have solved the problem.  It might not be the best answer, but it works good enough for now.  In my auto.master file I reference several map files (one for cdrom's, one for usb HD/solid state memory, and one for floopy).  After examining the debug output from the service, I noticed only one of the map files was being read.  My solution was to combine the contents of all the map files into one file.  I also had an error when referencing a usb device.  I didn't realize Fedora 8 maps usb drives to /dev/sdb1.  I always used sda1 under Fedora 5.  I'm not sure why autofs version 5 didn't let me reference more than one map file in my auto.master.  Thanks for all the help.
