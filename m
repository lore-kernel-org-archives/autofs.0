From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Race condition in autofs 4.1.4
Date: Fri, 26 Jan 2007 17:24:00 +0100
Message-ID: <1169828641.32447.22.camel@sangay.TechFak.Uni-Bielefeld.DE>
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

Hello!

We're currently in the process of migrating an old Solaris 2.8
mailserver to linux (debian etch). For testing purposes, we did the
following:

an nfsv4 fileserver serving the home directories
2 automount maps on the mailserver (don't ask ... ;))



auto.master is:
/nfs4homes      /etc/auto.mailhomes		-fstype=nfs4,-nosuid,grpid,proto=tcp,port=2049
/homes		/etc/auto.bind-mailhomes	-fstype=auto,bind


auto.mailhomes is:

musr1   10.0.0.1:/users/mail01/mail/&
musr2   10.0.0.1:/users/mail01/mail/&
musr3   10.0.0.1:/users/mail01/mail/&
[...]
musr1000   10.0.0.1:/users/mail01/mail/&


auto.bind-mailhomes is:

musr1   :/nfs4homes/&
musr2   :/nfs4homes/&
musr3   :/nfs4homes/&
[...]
musr1000   :/nfs4homes/&


This works: access to /homes/musr123 results in a successful nfs4-mount
of 10.0.0.1:/users/mail01/mail/musr123 to /nfs4homes/musr123 and a
successful bind-mount of /nfs4homes/musr123 to /homes/musr123, and mail
gets delivered properly.

The reason for this bind-mount thing is that we have in production a few
nfsv3 solaris fileservers, and the homedirectories for the users come
from different fileservers, all get mounted to /homes. The problem with
nfsv3 is that linux can't mount more than approximatly 100 shares at
once, so we plan to mount every fileservers /users to somewhere, so we
have all homes available, and let automount mount them to /homes/ per a
bind-mount.

We use a stress test on the machine, that sent about 150000 random sized
mails (up to 15k) to random users at random intervals, and under high
load, autofs seams to break here.

this is the current state of the /nfs4homes and /homes directories after
stopping the mail system and waiting for a few minutes (the timeout of
the automounter is set to 5 seconds, which triggers the bug after only a
few thousand mails delivered):


/homes/:
total 60
drwxr-xr-x 22 root    root        0 2007-01-26 16:40 .
drwxr-xr-x 24 root    root     4096 2007-01-26 16:35 ..
drwxr-xr-x  4 musr174 mailtest 4096 2007-01-17 17:28 musr174
drwxr-xr-x  4 musr253 mailtest 4096 2007-01-17 17:26 musr253
dr-xr-xr-x  2 root    root        0 2007-01-26 16:37 musr33
dr-xr-xr-x  2 root    root        0 2007-01-26 16:37 musr336
drwxr-xr-x  4 musr363 mailtest 4096 2007-01-18 15:28 musr363
drwxr-xr-x  4 musr403 mailtest 4096 2007-01-18 15:33 musr403
dr-xr-xr-x  2 root    root        0 2007-01-26 16:37 musr437
drwxr-xr-x  4 musr44  mailtest 4096 2007-01-18 14:01 musr44
drwxr-xr-x  4 musr46  mailtest 4096 2007-01-17 16:59 musr46
drwxr-xr-x  4 musr493 mailtest 4096 2007-01-22 15:50 musr493
dr-xr-xr-x  2 root    root        0 2007-01-26 16:36 musr549
drwxr-xr-x  4 musr602 mailtest 4096 2007-01-22 15:50 musr602
drwxr-xr-x  4 musr603 mailtest 4096 2007-01-22 15:51 musr603
dr-xr-xr-x  2 root    root        0 2007-01-26 16:37 musr646
dr-xr-xr-x  2 root    root        0 2007-01-26 16:37 musr657
drwxr-xr-x  4 musr662 mailtest 4096 2007-01-17 17:26 musr662
drwxr-xr-x  4 musr695 mailtest 4096 2007-01-18 15:28 musr695
drwxr-xr-x  4 musr860 mailtest 4096 2007-01-22 15:51 musr860
drwxr-xr-x  4 musr879 mailtest 4096 2007-01-18 15:14 musr879
drwxr-xr-x  4 musr918 mailtest 4096 2007-01-18 08:24 musr918

/nfs4homes:
total 60
drwxr-xr-x 24 root    root        0 2007-01-26 16:40 .
drwxr-xr-x 24 root    root     4096 2007-01-26 16:35 ..
dr-xr-xr-x  2 root    root        0 2007-01-26 16:37 musr117
drwxr-xr-x  4 musr200 mailtest 4096 2007-01-17 16:59 musr200
drwxr-xr-x  4 musr26  mailtest 4096 2007-01-18 08:24 musr26
drwxr-xr-x  4 musr311 mailtest 4096 2007-01-17 17:25 musr311
dr-xr-xr-x  2 root    root        0 2007-01-26 16:38 musr314
drwxr-xr-x  4 musr321 mailtest 4096 2007-01-17 17:28 musr321
dr-xr-xr-x  2 root    root        0 2007-01-26 16:37 musr33
drwxr-xr-x  4 musr363 mailtest 4096 2007-01-18 15:28 musr363
dr-xr-xr-x  2 root    root        0 2007-01-26 16:38 musr406
dr-xr-xr-x  2 root    root        0 2007-01-26 16:37 musr459
drwxr-xr-x  4 musr46  mailtest 4096 2007-01-17 16:59 musr46
drwxr-xr-x  4 musr489 mailtest 4096 2007-01-17 17:00 musr489
drwxr-xr-x  4 musr521 mailtest 4096 2007-01-22 15:54 musr521
drwxr-xr-x  4 musr532 mailtest 4096 2007-01-22 15:49 musr532
dr-xr-xr-x  2 root    root        0 2007-01-26 16:36 musr549
drwxr-xr-x  4 musr6   mailtest 4096 2007-01-17 17:00 musr6
dr-xr-xr-x  2 root    root        0 2007-01-26 16:39 musr70
drwxr-xr-x  4 musr819 mailtest 4096 2007-01-18 13:59 musr819
drwxr-xr-x  4 musr855 mailtest 4096 2007-01-22 15:50 musr855
dr-xr-xr-x  2 root    root        0 2007-01-26 16:38 musr946
drwxr-xr-x  4 musr948 mailtest 4096 2007-01-18 08:24 musr948
drwxr-xr-x  4 musr99  mailtest 4096 2007-01-18 15:36 musr99

You can clearly see that the directories that belong to root shouldn't
be there, at least they shouldn't be kept there.
autofs can't be restarted now - and it won't umount the remaining
correctly mounted directories. Only manual umounts of /homes/*
and /nfs4homes/* and a restart of the automounter afterwards fix this
problem for a short amount of time.

In syslog I get random messages like this:
Jan 26 16:39:29 demon automount[16757]: mount(generic): warning: /homes/musr657 is already mounted
Jan 26 16:39:42 demon automount[17062]: mount(generic): warning: /nfs4homes/musr946 is already mounted
for exactly the mountpoints that belong to root afterwards.

My guess is that the following happens:
1. postfix tries to deliver a mail
2. automounts mkdirs /nfs4homes/musr123 and mounts it
3. automount mkdirs /homes/musr123 and mounts it
4. mail gets delivered
...
5. the mounts get timeouts
6. automount umounts /homes/musr123
7. hey wait, postfix has another mail for musr123!
8. automount sees that /homes/musr123 is still mounted and does nothing
   (this is where the syslog message about the already mounted dir 
    possibly comes from)
9. the umount now finishes, leaving an empty /homes/musr123 behind,
   belonging to root:root
10. no rmdir /homes/musr123 happens?
11. the mail can't be delivered

and from here on, automount seems to work only half anymore: it still
mounts and umounts directories, but only new requests - the ones listed
above stay mounted. lsof shows that no process is using that directories
anymore ...

I hope this description was good enough for you to understand the
problem? I'd really like to help debugging this, but I'm not all that
familiar with strace and stuff. The mailserver is not in production, so
I'll be happy if I can penetrate it even more to find out the cause of
the problem :)

Thanks,
Lukas
