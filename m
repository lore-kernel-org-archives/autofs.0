From: Stef Bon <stef@bononline.nl>
Subject: Re: How to determine a path is a mountpoint.
Date: Fri, 19 Feb 2010 15:11:49 +0100
Message-ID: <201002191511.49512.stef@bononline.nl>
References: <201002152253.46863.stef@bononline.nl>
	<201002190018.37820.stef@bononline.nl>
	<4B7E0C1B.4040209@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B7E0C1B.4040209@themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Friday 19 February 2010 04:57:15 Ian Kent wrote:
> On 02/19/2010 07:18 AM, Stef Bon wrote:
> > On Wednesday 17 February 2010 15:25:08 Ian Kent wrote:
> > My fusemodule is an overlay fs, which mirrors another directory under
> > the directory under which it's mounted, and does some changes.
> 
> aka unionfs type behaviour?
> 
> You are in for a bundle of trouble if your trying to implement an
> overlay file system. If there are enough restrictions on functionality
> you might be able to get this working reliably but the locking alone
> will likely drive you nuts! You understand that once you play in kernel
> space you can have multiple concurrent code paths accessing and possibly
> changing the same data structures at the same time.

Well it's difficult, well not for me, but for the deveopers of FUSE. It's not in kernel space, but in userspace. Never heard of?

With Fuse one is able to write your own fs, by just writing what all the basic function do, like getattr, readdir, open, write and close. These are just a 
selection, look at the website for more info.

http://fuse.sourceforge.net/

Im not running into trouble, it's just an filesystem which happens to be an overlay fs.

My overlay is just like the mount --bind (or mount --rbind) command. It just mirrors the contents of one directory into another.But it does more. It 
reckognizes symbolic links which point to an autofs managed resource. Let me explain:

A tree to SMB resources look like
$HOME/Network/Windows Network/BONONLINE/ADMIN/admin	  -> /mnt/mount.md5key/sbon/mount/50b89942f697f095ac66359eae1b3a8f
                                            	  /documentation  -> /mnt/mount.md5key/sbon/mount/68141c6ce3077c8e438f7b31c3002053
                                                  /public	  -> /mnt/mount.md5key/sbon/mount/795e5d59a7901e91296cf6aae0987c94
                                                  /sbon	          -> /mnt/mount.md5key/sbon/mount/8236f6c5eae783204a24f447c4ea8ec3

where the keys (50b8999... and the others) are names of records in /var/cache/mount.md5key. Here the directories with these names exist, and contain 
information about the resource. This record is looked up by mount.md5key, and the real mountcommand is started, with the right parameters.

Now this is not ideal, cause were dealing with symbolic links, pointing to the targets. Most applications "forget" where they are coming from, which result in 
the user browsing in /mnt/mount.md5key/.... which should not happen. Futher, when accessing the directory of the server, and listing the contents,
everey share is mounted, cause almost all applications want to know what the target is what the links ar pointing at. And last but not least, a lot of 
applications in KDE (I do not know abou Gnome) search for a .directory file in the directory, making every target mounted.

To prevent this behaviour, I've started fuse-workspace-union, which mirrors the connectionstree (with allkinds of links to different resources) to the directory 
under which it's mounted, and does some things. First it will translate symbolic links, pointing to a directory in /mnt/mount.md5key/sbon/, into a directory.
This will make it look like the shares are directl mounted in the connectionsmap, while in fact it's just a trick.

mkdir -p /var/lib/workspace/sbon/{bind,conf}

mv $HOME/Network /var/lib/workspace/sbon/bind

mkdir $HOME/Workspace

start fuse-workspace-union with the right parameters:

/usr/bin/fuse-workspace-union $HOME/Workspace \
			      --bind-directory=/var/lib/workspace/sbon/bind \
                              --conf-directory=/var/lib/workspace/sbon/conf \
                              --autofs-mount-directory=/mnt/mount.md5key/sbon/mount \
                              --autofs-cache-directory=/var/cache/mount.md5key \
                              -o allow_root,default_permissions,use_ino 




Now when I do:
cd $HOME/Workspace/Network/Windows Network/BONONLINE/ADMIN
ls -l
drwxr-xr-x 2 sbon netgroup 61 2009-12-31 21:17 admin
drwxr-xr-x 2 sbon netgroup 61 2009-12-31 21:17 documentation
drwxr-xr-x 2 sbon netgroup 61 2009-12-31 21:17 public
drwxr-xr-x 2 sbon netgroup 61 2009-12-31 21:17 sbon


Futher it will intercept call's for a .directory file, which will make the resource to be mounted by the automounter, and present a standard .directory file 
instead.

FUSE does a lot of administration for me. It will generate inodes,   handle locks, is multitheaded. Extended attributes are supported, locking does work.
Only inotify is not implemented yet in my fs. 

I hope things get more clear now, after this long story.

In a previous mail I've said that the key directories in the autofs managed directory disappear when the resource is unmounted. I am wrong!
I've checked it again, and now the directories stay there, while the resource is not mounted. Huh?? How come??

My directory looks like:

root [ /usr/src/cblfs-200910/autofs-5.0.5 ]# /bin/ls -l /mnt/mount.md5key/sbon/mount/
total 0
dr-xr-xr-x 2 root root 0 2010-02-19 13:42 60ef51078836b9a9c78a3398f053d562
dr-xr-xr-x 2 root root 0 2010-02-19 13:42 7bfb90bb66496650c21925bd56a71bdc
dr-xr-xr-x 2 root root 0 2010-02-19 13:42 e23e33a53d5d08ad8f0425de4edd9309


while nothing is mounted:

root [ /usr/src/cblfs-200910/autofs-5.0.5 ]# mount | grep /mnt/mount.md5key/
root [ /usr/src/cblfs-200910/autofs-5.0.5 ]#


Is this behaviour normal? Is there a configuration switch?? Obvioulsy the automounter allows autofs directories to exists, while the are not connected.



Stef Bon



> 
> > Now how does my module know which share is mounted when building an
> > directory overview with readdir and applications like Dolphin are
> > searching for a .directory file. The call for this .directory file in
> > the target is intercepted by my fuse module, cause otherwise this
> > call will also make the automounter mount the share, while only the
> > .directory is looked up.
> > 
> > Now like I've said before, I cannot do a stat of the target key
> > directory, cause this will make the automounter to mount the share.
> > It's possible to make my fuse module to read the contents of
> > /mnt/mount.md5key/sbon/mount, and check the key to be investigated is
> > in this directory. I haven't tested this, but it should work.
> 
> It sounds like you have essentially got a kernel module here.
> 
> In that case you should not need to use an ioctl because you already
> have access to the same information that the mounted check ioctl has. If
> you are within a callback from kernel space deadlock is very likely
> going to happen if you start calling back to the kernel again via an ioctl.
> 
> Is this a kernel module you are working with or callbacks from the
> kernel? If it is then you really should be doing this a completely
> different way, like using d_lookup() to locate the dentry in the
> directory and then doing the checks. But I don't know exactly what
> environment you are working within yet so I can't quite help.
> 
> > Right now I looking for a way the automounter can give the answer. It
> > looks like the dev_ioctl_ismountpoint return -1 for the case the
> > share is not mounted, and *mountpoint is equal to 0. When mounted,
> > another filesystem is mounted, so *mountpoint is DEV_IOCTL_ISMOUNTED
> > 
> > | DEV_IOCTL_IS_OTHER.
> 
> The -1 is an error so maybe we can get more info from errno but lets
> continue this discussion after we work out what environment we are in
> from the question above.
> 
> Ian
