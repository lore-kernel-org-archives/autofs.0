From: giggzounet <giggzounet@gmail.com>
Subject: Automount /home for all the users when a user try to use
	/home
Date: Thu, 19 May 2011 09:10:45 +0200
Message-ID: <ir2fpp$6q3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi,

I'm using autofs for years and on different configurations. It works
great! so thx for your great work.

But I have a little question/problem:
We have a cluster (with CentOS 5.5). It's a little cluster, so the /home
"is" on the master. And this /home is exported to the nodes. I have
installed autofs in order to automount this /home when a user wants to
use his /home.

So at the moment the configuration is simple:
cat auto.master
/home   /etc/auto.home

cat auto.home
*      nfs_oscar:/home/&


So when a user comes autofs mounts only the /home for the user.

So at the moment it works. but I find it not optimal, because when 2
users try to connect from a node I get 2 mounts.

I would like to get this behaviour:
when a user try to connect to his /home, autofs mount all the export
/home. It is possible ?

Thx!
Best regards,
Guillaume
