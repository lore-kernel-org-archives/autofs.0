From: Stef Bon <stef@bononline.nl>
Subject: Re: sshfs and autofs
Date: Wed, 23 Dec 2009 22:47:44 +0100
Message-ID: <4B329000.3060101@bononline.nl>
References: <1261107485-sup-320@nixos> <1261173402-sup-9510@nixos>
	<4B2E48C7.8010509@bononline.nl> <1261391275-sup-7258@nixos>
	<4B311928.9070503@bononline.nl> <1261518309-sup-4721@nixos>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1261518309-sup-4721@nixos>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Marc Weber <marco-oweber@gmx.de>
Cc: autofs <autofs@linux.kernel.org>

Marc Weber wrote:
> Excerpts from Stef Bon's message of Tue Dec 22 20:08:24 +0100 2009:
>   
>> Marc Weber wrote:
>>     
>>>>> #  ls -l /auto
>>>>> ls: cannot access /auto/mlin: Permission denied
>>>>> total 0
>>>>> d????????? ? ? ? ?                ? mlin
>>>>>   
>>>>>       
>>>>>           
>>>> Well the question marks mean that glibc cannot figure out the 
>>>> permissions. This means probably
>>>> that the mount has not been succesfull.
>>>>     
>>>>         
>>> It was. The user can access it. But root can't.
>>>
>>>   
>>>       
>>>> Does this work. I do not know anything about ssh agents.
>>>>     
>>>>         
>>> Than you should start to learn at least some basics.
>>>       
> Sorry. I should have been more specific.
> I tried saying: If you have to login to multiple locations very often
> you should learn about ssh-agents because you'll benefit doing so.
>
> That's one point. The second point is if you still don't know about them
> and you're not going to read up what they are and why they are exist
> there is indeed no point you helping me because the reason I wrote that
> script was using ssh-agents.
>
> Anyway I think we can meet. You didn't reply to my question whether
> you're using empty passwords. So it looks to me that you're not aware
> about what I'm talking when saying "empty password". This looks strange
> to me because using automount directories per users seems to be
> advanced to me.
>
> Let me show you a complete example how to generate a key and use an
> ssh-agent:
>
>   # important: enter a passphrase
>
>   ssh-keygen -t rsa -f $HOME/id_rsa_tmp
>   Enter passphrase (empty for no passphrase): PASSWORD
>   Your identification has been saved in $HOME/id_rsa_tmp.
>   Your public key has been saved in $HOME/id_rsa_tmp.pub.
>     
>   # now you can copy your key to remote machine, you have to enter your
>   # remote password once:
>   ssh-copy-id -i $HOME/id_rsa_tmp.pub user@remote
>
>   Now you can login using
>   ssh -i $HOME/id_rsa_tmp user@remote
>
>   If you didn't use an empty password ssh will ask you for the id_rsa_tmp
>   password each time uses the key.
>   If you login and out frequently this is tedious. That's why you can do
>
>   tmp=$(ssh-agent)
>   echo "$tmp"
>   eval "$tmp"
>   ssh-add $HOME/id_rsa_tmp # thell the agent enter passphrase
>   # no more passwords required:
>   ssh user@remote 'echo done'
>   ssh user@remote 'echo done'
>   # kill agent so that when you leave the pc nobody
>   # else can use your key. You can also specify timeouts and such.
>   # (-> man ssh-agent)
>   pkill -9 ssh-agent 
>
> Of course if you're using an empty passphrase you don't need the
> ssh-agent at all.
> However if someone get's access to your private key he can login.
> If you use a passphrase he can't because he still has to know your
> passphrase.
>
> Now you've been using this line without ssh-agent:
>   
>>>> PasswordAuthentication='no' -o IdentityFile="$homedir/.ssh/id_dsa" -o 
>>>>         
>
> What would happen if you replaced .ssh/id_dsa with $HOME/id_rsa_tmp
> assuming you entered a passphrase?
> automount is running mount running sshfs running ssh
> which will find your password protected key. It doesn't know about any
> agents so it will try to ask you for the password by printing a
> "password:" prompt. But automount has no shell thus no prompt thus the
> mount will fail.
>   

Ok thanks for the explenation. This makes much more clear what the 
problem is. Let me explain my construction.
When a session begins, an autofs managed mountpoint is added to a 
seperate auto.master file, located in /var/run/autofs.
If a seperate automounter is not already running, it is started, with 
this auto.master file as paramter.
After login of root for example(on the login or via ssh - this is not 
really important how) this file looks like:

/mnt/mount.md5key/root/mount   /etc/autofs/auto.md5key   AUTOFS_USER=root

(this whole adding thing when a session  starts is done with help of 
ConsoleKit... in future I'll try Upstart)

Of course the directory /mnt/mount.md5key/root/mount is created first, 
and the directory /mnt/mount.md5key/root
has permissions 700  and is owned by the user for which this mountpoint 
is, in this case root.
But in any case no other user (except root, but in this case this is the 
same user) can enter the mountpoint and/or activate
it.

The file /etc/autofs/auto.md5key is the most simple map file:

*   -fstype=md5key   :/&

And this is a great feature of the automounter, the filesystem md5key 
does not have to be a "real" filesystem.
It just passes the filesystem type (md5key) to the mount command, which 
on his turn looks for the mount.md5key command,
which I've created, and is actually a wrapper to run the right mount 
command (mount.cifs, curlftpfs, sshs, .....or even mounting of USB).

Basicin this constrcution are "connection" records, where the 
information is stored about the remote or local address.
For samba shares, such a record is like:

cd /var/cache/mount.md5key/1bf8a01af6d3eb08ffa08b9b6578f514
/var/cache/mount.md5key/1bf8a01af6d3eb08ffa08b9b6578f514 ]# cat config
NET_service=smb
LOCAL_user=root
SMB_workgroup=BONONLINE
SMB_name=LFS20060812
SMB_share=public
SMB_ip=192.168.0.2
SMB_auth_method=guest

The md5key is the md5sum of this config file.

A config file for a SSH address may look like (I'm not using it at this 
moment so I may forget something):

NET_service=ssh
LOCAL_user=root
SSH_server=192.168.0.2
SSH_auth_method=agent

Now the md5sum of this file is 2b2468c31ab6a00a3f47d5df01d7a116, create 
this directory:

install -d /var/cache/mount.md5key/2b2468c31ab6a00a3f47d5df01d7a116

and move this record in it:

mv <from somehere>/config  
/var/cache/mount.md5key/2b2468c31ab6a00a3f47d5df01d7a116

Now to access this resource, direct access is not very userfriendly, the 
md5keys only make sense to the computer, not the user.
I've created a script which scans the cache (in 
/var/cache/mount.md5key/) for available resources for a user, and 
creates a tree in the
homedirectory, which makes sense to the user, with symboliclinks to the 
right md5key entries:

For me still as root this looks like:

~/Network/Windows Network/BONONLINE/LFS20060812/public -> 
/mnt/mount.md5key/root/mount/1bf8a01af6d3eb08ffa08b9b6578f514

and

~/Network/SSH access/192.168.0.2 -> 
/mnt/mount.md5key/root/mount/2b2468c31ab6a00a3f47d5df01d7a116

When entering these directories, (read following the link) the 
mount.md5key command looks for the key in /var/cache/mount.md5key/ 
directory,
finds it, looks for the config file and launches the right mount command 
with the right parameters.

You see the whole intelligent thing is done by the mount.md5key command, 
getting al the right information out off the config file.

Now there are more I can tell you about this. The information about 
remote and local resources is not static. With Samba shares there are some
utilities which cann help you to find out the resources a user logged in 
has access to, like nbtscan, nmblookup and smbclient.
For other resources there might be other utilities.
Futher I do not like these symbolic links. When following them, you as 
user might end up with your
favorite app in /mnt/mount.md5key/%USER%/mount directory, looking to 
strange looking directories on a strange place in the filesystem. Thats 
the reason
I'm working on an fuse modules (fuse-workspace I've called it) which 
mirrors this connections tree, where it's possible to make some symbolic 
links look like directories. It's too complicated, but look at

http://linux.bononline.nl/linux/fuse-workspace/index.php

and

http://linux.bononline.nl/linux/mount.md5key/index.php
http://linux.bononline.nl/linux/runsessionscripts/index.php


Now to get back to your problem, as I understand it, I've read some 
manpages, and yes I'm using private/public keys without
passphrase. I did not know about agents until now. I understand that 
this communication through this agent makes it easier to make a ssh 
connection.
If I'm wrong please correct.
Next add the .ssh/id_dsa and .ssh/id_rsa and .ssh/identity files with 
ssh-add. If this is done, other applications do not have to enter the 
passphrase
anymore, if they make use of this agent, which they can find though the 
environment variables.

But the ssh-add command asks for the passphrase, and if done in an 
environment with the automounter you have a problem here, I understand.
In my setup the mount.md5key command has to find out who is activating 
the mount, and what the evironment is (simple terminal or X) and present
a "passphrase" dialog. Apart problem: how to store the information about 
the agent for other apps.

This is the whole problem, because this is not easy. The automounter 
(read man 5 autofs) can offer variables like USER, UID, etc,HOST
of the user requesting the mount (according to the manpage). Then to 
present this user a suitable dialog... maybe via dbus???

I do not have a sollution for you here, sorry, I can ony analyze it's 
difficult.
I think that your script tries to offer a dialog somehere, but that it 
does not reach you as user...
Earlier I've thought about this when entering a Windows/Samba share, but 
I left it for exact these reasons.


Somebody else??


Stef Bon










> For this reason you find many howtos when googling telling you how to
> setup keys with empty passwords because this just works.
>
> I have two goals:
> a) figuring out whether there are even nicer solutions
> b) telling people that they can use password protected private keys and
> automount using my script.
>
>   
>> Here again I'm trying to help here.
>>     
> Thanks for doing so.
>
> I hope that this mail showing you how to use ssh-agents does help you a
> little bit understanding my configuration.
>
> Marc Weber
>
>   
