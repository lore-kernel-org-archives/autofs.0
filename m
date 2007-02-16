From: "Dark Charlot" <jcldc13@gmail.com>
Subject: Automount dies
Date: Fri, 16 Feb 2007 10:35:56 +0100
Message-ID: <dd64c4a50702160135o1e5ec23fyc7a0f0d63ac6033b@mail.gmail.com>
Reply-To: test@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

automout version : autofs-5.0.1-0.rc2

Hello,
  for a long time ago I am using automount on a cluster of 40
computers without problems, but since I have upgraded to automount v5
I am running into troubles. For some reasons, the automount daemon
dies (after several days)..... Command 'ps' does not report a running
automount process. The file /var/lock/subsys/autofs is still there.
The only message I get from the file "/var/log/messages" is :

Feb 15 04:03:29 ios automount[3058]: send_ready: AUTOFS_IOC_READY:
error Inappropriate ioctl for device

 .. but I don't know if it is relevant to my problem.

 If I restart the daemon, everything goes fine until the next death.
As I said, it can take several days before dying and it's not easy
reproductible.

 Here is an overview of my network :
(I am using NIS)

- 3 servers share their filesytems (high speed raid 5 filesystems)

- 30 clients (autofs-5.0.1-0.rc2) auto mount servers's filesystems
          more than 15 clients have already had pbs with their automount

- 8 clients (autofs-4.1.3) automount servers's filesystems
         I did not have any problems with these clients for more than 2 years

here is the file, /etc/autofs/auto.master:

# direct map
/net/direct /etc/auto.direct
# 100 HD from beowulf
/net/hd100      auto.yp_hd100
# local filesystems
/net/local      auto.local_pp
# hd on LAN host
/net/fs         auto.yp_host_fs
# home
/home   /etc/auto.home

   Thanks in advance for your help.

JC
