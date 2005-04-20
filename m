From: Jim Carter <jimc@math.ucla.edu>
Subject: RE: mount -o bind
Date: Tue, 19 Apr 2005 22:42:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.61.0504192158380.14524@xena.cft.ca.us>
References: <200504192203.j3JM3CJ32241@mail.velociti.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200504192203.j3JM3CJ32241@mail.velociti.us>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lucas Peet <lpeet@velociti.us>
Cc: autofs@linux.kernel.org

On Tue, 19 Apr 2005, Lucas Peet wrote:
> Say I have a 200GB drive in the system for a central shared filestore,
> mounted as /data.  I have this shared via Samba on the network.  I want this
> to be available as /home/users/lpeet/data (for each user in /home/users) so
> it can be accessed via FTP as well.

If ftpd chroots to the user's homedir, and the user then refers to 
~user/data, if a automount process were already mounted on that directory 
with a suitable map, it could bind-mount outside directories onto 
subdirectories of ~user/data.  But I'm sure you don't want to pre-create 
one automount process per user.  

What you really want is for the FTP daemon to run a script when setting up 
a session, which could bind-mount the /data directory, and to run another 
script at session end, to unmount it.  But I went over the man page for 
vsftpd and I didn't see any such facility.  Possibly a less paranoid FTP 
daemon might do it for you, with a corresponding weakening of security.

Why are you doing the chroot?  Do you need to protect the users from each 
other?  Or is the main focus on keeping the users out of central system 
files?  Said another way, if a hacker gets on as user X, he can trash 
X's homedir or steal his secret stuff, but assuming that he's exploiting 
something that lets him get through UNIX file permissions (but not a 
chroot), which files do you particularly want to keep safe?  The reason I 
ask is, you might consider a directory structure like this:

/home/users/user1
/home/users/user2...
/home/users/data      (bind mount from /data, or just mount it here)

Then if the chroot for everyone was to /home/users, everyone could get at 
the shared directory any time they wanted.  But they could also attempt to 
get at any other user's homedir, and you would have to trust UNIX file 
permissions to keep those files safe, as well as the ones in 
/home/users/data.  Whereas, the hacker would have to break the chroot (as 
well as UNIX file permissions) to get at /etc and the contained host and 
user keys.

> So...does this mean that since there's only one mapping, using a wildcard,
> that if say one user logs in, access the directory, that automount will
> mount the directory for every user or just the user that requested it to be
> mounted?  At the same time, if the timeout occurs for one user, will it
> unmount the directory for all the users? Or will it leave the directory
> mounted for all the users and wait until the last user has stopped accessing
> it, and unmount it for all the users at that time?

Each bind mount would be created individually, and would time out 
individually, even though /data would potentially be mounted for multiple 
users.  However, I'm having trouble figuring out on which directory the 
automount process should be mounted.  I haven't used multi-mounts before, 
so be very cautious about what follows (I probably should keep my mouth 
shut here but...)  Perhaps you want a mount point of automount, let's call 
it /ftp, and the map row would look like:

/ftp/* -bind /home/users/& /home/users/&/data

So how does automount know *what* to mount on /ftp/&/data?  If 
/home/users/&/data is a symlink to /data, it's clear what to mount, but 
you'll end up mounting /data onto /data, which is useless at best and 
probably not healthy.  If /home/users/&/data is a directory then there's no 
magic for what to mount on it.  If by accident it's missing, you get nasty 
messages cluttering up your logs.  So this solution probably isn't going to 
fly.  Sorry.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
