From: Thanh Tran <ttran7700@yahoo.com>
Subject: Automount Not Working Under Fedora 8
Date: Tue, 12 Aug 2008 07:21:44 -0700 (PDT)
Message-ID: <17100.60638.qm@web54301.mail.re2.yahoo.com>
Reply-To: ttran7700@yahoo.com
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

I've been working with Fedora 5.  I got automounter to work perfectly.  I recently moved to Fedora 8.  Now I can't get automount to do anything.  After moving to Fedora 8, I did a yum install autofs.  I noticed Fedora 5 uses version 4 of autofs while 5 uses version 5.  I modified my auto.master to match the one on Fedora 5.  It should work but does not.  I think the auto.master is not loading.  How can I get it working?  Is there a tutorial for version 5 of autofs?  I tried the wiki and it looks pretty empty.  Judging by the difference in the autofs scripts, the two versions must be very different.
