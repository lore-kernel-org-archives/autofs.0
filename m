From: Matt Bernstein <mb--autofs@dcs.qmul.ac.uk>
Subject: quota/indirection problem
Date: Mon, 22 Sep 2003 15:15:19 +0100 (BST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0309221452400.5636@lucy.dcs.qmul.ac.uk>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hi,

This is a little difficult to describe, but is quite a nasty problem.

Our home directories are defined as being
	/homes/$LOGNAME
which (via an autofs bind mount) abstracts to
	:/home/server/volume [1]
which in turn (another autofs bind mount) abstracts to
	:/server/SERVERNAME/PATH
which is an autofs NFS mount.


Now, at first this all works swimmingly and when I log in df tells me what 
I wanted:

cream:/export61       48078504  42604528   3031696  94% /server/cream/export61
/server/cream/export61/users
                      48078504  42604528   3031696  94% /home/cream/home61
/home/cream/home61/mb
                      48078504  42604528   3031696  94% /homes/mb

..and my quota works perfectly:

Disk quotas for user mb (uid 5154):
     Filesystem  blocks    quota   limit   grace   files   quota   limit   grace
cream:/export61  753432  3000000 7000000           16290       0       0

However, after the timeout kicks in only the "/homes/mb" mount is visible 
to df--I guess Deep VFS Magick keeps everything internally in order, and 
my home directory still works fine. BUT..

Disk quotas for user mb (uid 5154): none

SO.. I would really like the NFS mount to persist so that the "quota" 
command produces the output you'd expect.

Can anyone help? Please.. before our students come back and ruin everything..

Our machines use autofs 3. I'm happy to try out bleeding-edge software 
on client machines if anyone thinks it might help..

Matt


[1] The idea is that "/home/server/path" can be different for different
networks, ie our staff machines can have an auto.master like this:

/homes          ldap:ou=auto.homes
/homes.itl      ldap:ou=auto.homes.itl

..and on the "itl" network, like this:

/homes          ldap:ou=auto.homes.itl

Both master maps include:

/server/cream   ldap:ou=auto.server.cream
/server/custard ldap:ou=auto.server.custard
/home/cream     ldap:ou=auto.home.cream
/home/custard   ldap:ou=auto.home.custard
