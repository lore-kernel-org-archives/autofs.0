From: Stef Bon <stef@bononline.nl>
Subject: Indirect mounts: name of network as key.
Date: Tue, 22 Apr 2008 10:48:43 +0200
Message-ID: <480DA66B.9020806@bononline.nl>
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

Hello,

since some time I'm working on a sollution to provide access to the 
network with autofs.
My construction adds an entry to the auto.master file:

/home/sbon/Global\ Network    /etc/autofs/session/auto.network.sbon --browse

The auto.network.sbon file is a symlink to auto.network.

The directory "Global Network" is owned by root.

The script auto.network.sbon creates a map depending the key. The key is 
the name
of the network. When the key is for example "Windows Network", it's 
output is:

-fstype=cifs,credentials=/home/sbon/.autofssession/smb/mount.cred \
    /BONONLINE/LFS20060812/bononline -rw,ip=192.168.0.2 
://LFS20060812/bononline \
    /BONONLINE/LFS20060812/ftp -rw,ip=192.168.0.2 ://LFS20060812/ftp \
    /BONONLINE/LFS20060812/sbon -rw,ip=192.168.0.2 ://LFS20060812/sbon \
    /BONONLINE/LFS20060812/video -rw,ip=192.168.0.2 ://LFS20060812/video \
    /CWWERKGROEP/ROUTER/public -rw,ip=192.168.0.1 ://ROUTER/public \
    /CWWERKGROEP/ROUTER/sbon -rw,ip=192.168.0.1 ://ROUTER/sbon

When the key is "SSH hosts", it's output is:

-fstype=sshfs \
    /192.168.0.1 -rw,nodev,nonempty,noatime ://sbon@192.168.0.1:/ \
    /192.168.0.2 -rw,nodev,nonempty,noatime ://sbon@192.168.0.2:/ \

(the mount.sshfs is a script which calls the sshfs fuse program with the 
right parameters)
( the script auto.network determines these maps dynamically..)

Now when a session for a user starts, the line for this 
("/home/sbon/Global\ Network  /etc/autofs/se...")
is added to the auto.master file.
If the automount daemon is not running, it is started here, else the 
running automounter gets a reload.

This construction gives a very good way to access the network. It comes 
very near to what I'm looking for. It provides
easy access to various network services. At the same time, because of 
the use of cifs for smb networks, advanced
features are supported.

The only problem to activate the map, and to keep is "up". Normally when 
I do something like:

:> cd "/home/sbon/Global Network"
:> ls
(gives no output, I have to do:)
:> ls "Windows Network"
BONONLINE CWWERKGROEP
(now I've got a browseable map, where the shares are only mounted when 
accessed, what is good! Simular:)
:> ls "SSH hosts"
192.168.0.1 192.168.0.2

I solve this by doing a ls "%Network Name%" for all the networks 
available to an user. Well a script does that.

There is only one thing where this construction goes wrong, and that is 
that the automounter sometimes "forgets"
the whole tree, for example the "Windows Network" tree. Than I see only 
the tree "SSH hosts".
This has something to do with the timeout option. This option applys to 
the active mounts (cifs and sshfs here),
but as far I can see also to the whole browseable tree.
Now it's obvious, when setting this value here to zero, and thus 
disabling this behaviour, solves the problem.
It leaves the whole browseable tree intact. But now the cifs and sshfs 
shares are not unmounted anymore, when they are
unused for some time... This is not so good, because this is one of the 
pros of the automounter.

Is there a way to make the timeout option only apply to the actual 
external mounts, and leave the browseable tree?

Thanks in advance,

Stef Bon
