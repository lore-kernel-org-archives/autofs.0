From: Matthew Johnson <johnno@deakin.edu.au>
Subject: homedir mounts with 0 files
Date: Thu, 12 Feb 2004 17:48:03 +1100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200402120648.i1C6m4s7030467@deakin.edu.au>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Anyone seen any behaviour like this .. 
any suggestions/help ..

Continual recurrence of this in /var/log/messages
                                                                                
Feb 10 02:24:22 server_name automount[20711]: BUG: /home/user1 already mounted
Feb 10 02:24:22 server_name automount[20712]: BUG: /home/user2 already mounted
...
Feb 10 02:24:22 server_name automount[20713]: BUG: /home/usern already mounted
                                                                                
                                                                                
Some users home directories are mounted incorrectly.
Not seeing any files.
After unmount autofs then mounts it back in correctly.
But problem is recurring.

Linux kernel 2.4.24
autofs 4.1.0


Matthew Johnson
