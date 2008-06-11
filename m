From: cedric briner <work@infomaniak.ch>
Subject: automount reload
Date: Wed, 11 Jun 2008 08:07:38 +0200
Message-ID: <484F6BAA.2050703@infomaniak.ch>
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
To: autofs <autofs@linux.kernel.org>

ubuntu: 8.04

#uname -a
Linux obslw32 2.6.24-17-generic #1 SMP Thu May 1 13:57:17 UTC 2008 
x86_64 GNU/Linux

# dpkg -l autofs
ii  autofs                                4.1.4+debian-2.1ubuntu1 
        kernel-based automounter for Linux

-----------------------------------------------

Hello the autofs team,

I'm using autofs in team with nis. I do have defined auto_home with a 
list of users and their respectives ressources. And I use intensively nfs.

The question is.
How should I proceed when I'd like to move, let'say, user joe 
(/home/joe) from hostA:/export/joe to hostB:/export/joe when he is 
actually log in hostW(ork)

I thought, I'll do in this order:
ask joe to log out
rsync hostA:/export/joe to hostB:/export/joe
on hostB: exportfs of hostB:/export/joe

in nis: auto_home, I move joe hostA:/export/joe to
                               hostB:/export/joe

on hostW: /etc/init.d/autofs reload

but it is not working.
-- 

Cedric BRINER
Geneva - Switzerland
