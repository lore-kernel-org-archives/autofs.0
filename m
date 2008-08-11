From: Ondrej Valousek <webserv@s3group.cz>
Subject: Automounter hangs...
Date: Mon, 11 Aug 2008 15:11:55 +0200
Message-ID: <48A03A9B.2070402@s3group.cz>
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

Hi List,

I have strange error (RHEL-4, autofs 4.1.3-234). Using automounter to
mount home directories for users. After a while, /home got unusable and
I see the following:

root     17345 20453  0 10:33 ?        00:00:00 [automount] <defunct>
root     17348 20453  0 10:33 ?        00:00:00 [automount] <defunct>
root     20453     1  0 Aug05 ?        00:00:15 /usr/sbin/automount
--timeout=60 --debug /home yp auto.home -rw


I can not kill any of the processes listed (tried even kill -9).
The last I can see in /var/log/messages is the following:
Aug 11 10:32:39 login01 automount[17100]: expired /home/login
Aug 11 10:33:01 login01 automount[20453]: attempting to mount entry
/home/login
Aug 11 10:33:01 login01 automount[17185]: mount(nfs): mounted
belfast:/vol/users/users/login on /home/login
Aug 11 10:33:09 login01 automount[17346]: expired /home/localmgr
Aug 11 10:33:09 login01 automount[17348]: expired /home/support

Maybe, the processes 17346 and 17348 failed to unmount /home/support and
/home/localmgr. This perhaps caused even the parent process 20453 to hang.

Has anyone seen anything similar? Is there any solution to this?
Thanks,

Ondrej
