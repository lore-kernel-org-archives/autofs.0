From: Phy Prabab <phyprabab@yahoo.com>
Subject: reload of maps
Date: Wed, 18 Aug 2004 18:34:43 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040819013443.27854.qmail@web51803.mail.yahoo.com>
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

Hello,

I have an interesting issue autofs/automount/mount
issue.


I change a map for a user within auto.home and make
sure it is in NIS and ldap.  I then go to the client
machine and verify that the nis or ldap map (have
tried it with both ldap and nis) has/have been
updated.  I then make sure the user if logged off and
then issue an autofs reload.  However, automount/mount
continues to use the old mount point.  Even after I
unmount the mount point and "reload" autofs, the mount
point never changes.  The only way I have been able to
fix this is by rebooting the machine which is
generally not an acceptable solution.

So am I missing something?

kernel 2.6.7
autofs 4.1.3
mount-2.11z

Any help is greatly appreciated!

Phy



		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
