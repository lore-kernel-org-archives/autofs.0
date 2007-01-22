From: Sandra Bonus <mrsbonus1@yahoo.com>
Subject: Windows administrative shares broken by v5
Date: Sun, 21 Jan 2007 18:19:32 -0800 (PST)
Message-ID: <20070122021932.57879.qmail@web35515.mail.mud.yahoo.com>
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

I'm running fedora Core

I had made a similar patch to the one described in 
http://linux.kernel.org/pipermail/autofs/2006-December/003554.html

to allow the mounting of Windows administrative shares
This was all fine on v4.1.4

However as soon as I installed v 5.0.1-0.rc3.2 this was broken and shares ending in $ could not be mounted. I played around with the output of /etc/auto.smb for a while but could not work out a variation that made the admin shares work again.

Any ideas?




 
____________________________________________________________________________________
Want to start your own business?
Learn how on Yahoo! Small Business.
http://smallbusiness.yahoo.com/r-index
